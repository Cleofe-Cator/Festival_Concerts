const admin = require('firebase-admin');
const fs = require('fs');
const path = require('path');

const serviceAccountPath = process.env.SERVICE_ACCOUNT_PATH || path.join(__dirname, 'serviceAccountKey.json');
if (!fs.existsSync(serviceAccountPath)) {
  console.error('Service account key not found. Set SERVICE_ACCOUNT_PATH or place serviceAccountKey.json in scripts/.');
  process.exit(1);
}

const serviceAccount = require(serviceAccountPath);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const firestore = admin.firestore();

async function seed() {
  const dataPath = path.join(__dirname, 'initial_data.json');
  if (!fs.existsSync(dataPath)) {
    console.error('initial_data.json not found in scripts/.');
    process.exit(1);
  }

  const raw = fs.readFileSync(dataPath, 'utf8');
  const data = JSON.parse(raw);

  for (const collectionName of Object.keys(data)) {
    const docs = data[collectionName];
    console.log(`Seeding collection: ${collectionName} (${docs.length} docs)`);
    for (const doc of docs) {
      const id = doc.id || firestore.collection(collectionName).doc().id;
      const docData = Object.assign({}, doc);
      delete docData.id;
      await firestore.collection(collectionName).doc(id).set(docData);
      console.log(`  - wrote doc ${collectionName}/${id}`);
    }
  }

  console.log('Seeding finished.');
  process.exit(0);
}

seed().catch(err => {
  console.error('Seeding failed:', err);
  process.exit(1);
});
