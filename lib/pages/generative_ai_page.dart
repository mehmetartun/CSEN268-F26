import 'package:cloud_functions/cloud_functions.dart';
import 'package:material_ui/material_ui.dart';

import '../model/cocktail_recipe.dart';

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

class GenerativeAiPage extends StatefulWidget {
  const GenerativeAiPage({super.key});

  @override
  State<GenerativeAiPage> createState() => _GenerativeAiPageState();
}

class _GenerativeAiPageState extends State<GenerativeAiPage> {
  CocktailRecipe? recipe;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String cocktailName = "Mojito";
  bool readOnly = false;
  HttpsCallable getRecipeCall = FirebaseFunctions.instance.httpsCallable(
    'getRecipe',
  );

  void snack(String text) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
    }
  }

  void getRecipe() async {
    try {
      HttpsCallableResult result = await getRecipeCall.call({
        'schema': CocktailRecipe.schema,
        'prompt': 'Get me the recipe of $cocktailName cocktail.',
        'languageModel': 'gemini-2.5-flash',
      });
      recipe = CocktailRecipe.fromJson(_castMap(result.data));
      setState(() {
        readOnly = false;
      });
    } catch (e) {
      snack(e.toString());
      setState(() {
        readOnly = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getRecipe();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cocktail Recipe")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Recipe"),
              Form(
                key: formKey,

                child: TextFormField(
                  initialValue: cocktailName,
                  readOnly: readOnly,
                  onSaved: (value) {
                    cocktailName = value ?? "";
                  },
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length < 3) {
                      return "Please enter a cocktail name";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    suffix: IconButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          setState(() {
                            readOnly = true;
                          });
                          formKey.currentState!.save();

                          getRecipe();
                        }
                      },
                      icon: Icon(Icons.check),
                    ),
                    hintText: "Cocktail Name",
                  ),
                ),
              ),

              if (recipe != null) ...[
                Text(
                  recipe!.cocktailName,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  recipe!.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "History",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(recipe!.history),
                Text(
                  "Serving",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(recipe!.servingFormat),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
