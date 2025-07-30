describe('group 1', () => {
  beforeAll(() => {
    console.log('beforeAll');
    // Up db
  });
  afterAll(() => {
    console.log('afterAll');
    // Down db
  });
  beforeEach(() => {
    console.log('beforeEach');
    // Reset db
  });
  afterEach(() => {
    console.log('afterEach');
    // Clear db
  });

  test('case 1', () => {
    console.log('case 1');
    expect(1 + 1).toBe(2);
  });
  test('case 2', () => {
    console.log('case 2');
    expect(2 + 3).toBe(5);
  });

  describe('group 2', () => {

      beforeAll(() => {
    console.log('beforeAll');
    // Up db
  });
    test('case 3', () => {
      console.log('case 3');
      expect(3 + 3).toBe(6);
    });
    test('case 4', () => {
      console.log('case 4');
      expect(4 + 4).toBe(8);
      });
    });
  });
