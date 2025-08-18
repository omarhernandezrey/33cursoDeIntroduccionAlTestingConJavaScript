const request = require('supertest');

// Mock the MongoLib used by the services to avoid real DB calls in E2E tests
const mockGetAll = jest.fn();
jest.mock('../../src/lib/mongo.lib', () => jest.fn().mockImplementation(() => {
    return {
        getAll: mockGetAll,
        create: () => {},
    };
}));

const createApp = require('../../src/app');

const generateManyBook = (quantity) => {
    return Array.from({ length: quantity }).map((_, idx) => ({
        id: `${idx + 1}`,
        name: `Book ${idx + 1}`,
    }));
};

describe('Test for books', () => {
        let app = null; 
        let server = null;

        beforeAll(() => {
                app =  createApp();
                server = app.listen(3001);
        });

        afterAll(async () => {
             await server.close();
        });

        describe('test for [GET] /api/v1/books',() => {
                test('should return a list books',() => {
                        // Arrange
                        const fakeBooks = generateManyBook(3);
                        mockGetAll.mockResolvedValue(fakeBooks);
                        // Act
                        return request(app)
                                .get('/api/v1/books')
                                .expect(200)
                                .then(({ body }) => {
                                        console.log(body);
                                        // Assert
                                        expect(body.length).toEqual(fakeBooks.length);
                                });
                });
        });
});
