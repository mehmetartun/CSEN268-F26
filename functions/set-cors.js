const { Storage } = require('@google-cloud/storage');
// Initialize storage with your service account credentials
const storage = new Storage({
    keyFilename: '../google_app_engine_service_account.json',
});
const bucketName = 'csen268-f25.firebasestorage.app';
async function configureBucketCors() {
    await storage.bucket(bucketName).setCorsConfiguration([
        {
            maxAgeSeconds: 3600,
            method: ['GET', 'HEAD', 'OPTIONS'],
            origin: ['http://localhost:5500', 'https://csen268-f25.web.app',
                'https://csen268-f25.firebaseapp.com'], // Change to your specific domain for production
            responseHeader: ['Content-Type', 'Authorization',
                'Content-Length', 'User-Agent'],
        },
    ]);
    console.log(`CORS configuration successfully updated for ${bucketName}`);
}
configureBucketCors().catch(console.error);