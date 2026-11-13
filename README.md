# Lecture 17 - Generative AI

## Setting Secret
Running the following and then pasting the key here:
```bash
firebase functions:secrets:set GEMINI_API_KEY
```

## Recipe function
We add this function to index.js

```javascript
exports.getRecipe = onCall({
    secrets: ['GEMINI_API_KEY'],
    timeoutSeconds: 540,
}, async (request) => {
    const schema = request.data.schema;
    const languageModel = request.data.languageModel;
    try {
        const model = genAI.getGenerativeModel({
            model: languageModel,
            generationConfig: {
                responseMimeType: 'application/json',
                responseSchema: schema,
            },
        });

        const safetySettings = [
            {
                category: HarmCategory.HARM_CATEGORY_HARASSMENT,
                threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
            },
            {
                category: HarmCategory.HARM_CATEGORY_HATE_SPEECH,
                threshold: HarmBlockThreshold.BLOCK_MEDIUM_AND_ABOVE,
            },
        ];
        const prompt = request.data.prompt;
        const result = await model.generateContent({
            contents: [{ role: 'user', parts: [{ text: prompt }] }],
            safetySettings,
        });
        const response = result.response;
        if (!response || !response.candidates || !response.candidates[0].content) {
            throw new Error('Invalid response from Gemini API.');
        }
        const jsonString = response.candidates[0].content.parts[0].text;
        const recipeJson = JSON.parse(jsonString);
        return recipeJson;
    } catch (error) {
        console.error('Error calling Gemini API:', error);
        if (error.response) {
            console.error('API Response Data:', error.response.data);
        }
        res.status(500).send(`Error processing request: ${error.message}.`);
        return { 'error': error.message };
    }
});
```

We call this from our app with a schema:
```dart
static Map<String, dynamic> get schema {
    Map<String, dynamic> schema = {
      'type': 'OBJECT',
      'properties': {
        'cocktail_name': {'type': 'STRING'},
        'description': {'type': 'STRING'},
        'total_calories_in_kCal': {'type': 'NUMBER'},
        'total_volume_in_mL': {'type': 'NUMBER'},
        'history': {'type': 'STRING'},
        'alcohol_by_volume_%': {'type': 'NUMBER'},
        'serving_format': {'type': 'STRING'},
        'total_carbohydrates_in_g': {'type': 'NUMBER'},
        'total_protein_in_g': {'type': 'NUMBER'},
        'total_fat_in_g': {'type': 'NUMBER'},
        'ingredients': {
          'type': 'ARRAY',
          'items': {
            'type': 'OBJECT',
            'properties': {
              'name': {'type': 'STRING'},
              'quantity_in_mL': {'type': 'NUMBER'},
              'carbohydrates_in_g': {'type': 'NUMBER'},
              'protein_in_g': {'type': 'NUMBER'},
              'fat_in_g': {'type': 'NUMBER'},
              'calories_in_kCal': {'type': 'NUMBER'},
              'alcohol_by_volume_%': {'type': 'NUMBER'},
            },
          },
        },
        'instructions': {
          'type': 'ARRAY',
          'items': {
            'type': 'OBJECT',
            'properties': {
              'step': {'type': 'NUMBER'},
              'description': {'type': 'STRING'},
            },
          },
        },
      },
      'required': [
        'cocktail_name',
        'ingredients',
        'instructions',
        'description',
        'total_calories_in_kCal',
        'total_volume_in_mL',
        'history',
      ],
    };
    return schema;
  }
```

which is attached to the `CocktailRecipe` object.

Calling it from our app:
```dart
   HttpsCallableResult result = await getRecipeCall.call({
        'schema': CocktailRecipe.schema,
        'prompt': 'Get me the recipe of $cocktailName cocktail.',
        'languageModel': 'gemini-2.5-flash',
      });
      recipe = CocktailRecipe.fromJson(_castMap(result.data));
```

Here the data coming back from the cloud function is not of `Map<String,dynamic>` type. Therefore we use this function to convert:
```dart
Map<String, dynamic> _castMap(Map<Object?, Object?> map) {
  return map.map((key, value) {
    if (value is Map<Object?, Object?>) {
      return MapEntry(key as String, _castMap(value));
    }
    if (value is List) {
      return MapEntry(
        key as String,
        value
            .map(
              (item) => item is Map<Object?, Object?> ? _castMap(item) : item,
            )
            .toList(),
      );
    }
    return MapEntry(key as String, value);
  });
}
```