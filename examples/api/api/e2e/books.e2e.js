const request = require('supertest');
const {MongoClient} = require('mongodb');

const createApp = require('../../src/app');
const {config} = require('../../src/config');

const DB_NAME = config.dbName;
const MONGO_URL = config.dbUrl;

describe('Test for books', () => {
  let app = null;
  let server = null;
  let database = null;
  beforeAll(async () => {
    app = createApp();
    server = app.listen(3001);
    const client = new MongoClient(MONGO_URL, {
      useNewUrlParser: true,
      useUnifiedTopology: true
    });
    await client.connect();
    database = client.db(DB_NAME);
  });

  afterAll(async () => {
    await server.close();
  });

  beforeEach(async () => {
    await database.collection('books').deleteMany({});
  });

  describe('test for [GET] /api/v1/books', () => {
    test('should return a list books', async () => {
      // Arrange
      const seedData = await database.collection('books').insertMany([
        { name: 'Book 1', author: 'Omar', year: 1990 },
        { name: 'Book 2', author: 'Ana', year: 2001 },
        { name: 'Book 3', author: 'Luis', year: 2015 }
      ]);
      console.log('Seed data inserted:', seedData);

     await seedData;
      // Act
      return request(app)
        .get('/api/v1/books')
        .expect(200)
        .then(({ body }) => {
          console.log(body);
          // Assert
          expect(body.length).toEqual(seedData.insertedCount);
        });
    });
  });
});
