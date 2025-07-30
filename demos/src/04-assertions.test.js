// matchers
test('test obj', () => {
  const data = { name: 'Omar' };
  data.lastName = 'Hernández';
  expect(data).toEqual({ name: 'Omar', lastName: 'Hernández' });
});

test('null', () => {
  const data = null;
 expect(data).toBeNull();
 expect(data).not.toBeUndefined();
});

test('boolean', () => {
  expect(true).toEqual(true);
  expect(false).toEqual(false);

  expect(0).toBeFalsy();
  expect('').toBeFalsy();
  expect(false).toBeFalsy();
});

test('String', () => {
  expect('Omar').toMatch(/Omar/);
  expect('Omar').not.toMatch(/Hernández/);
  expect('Omar Hernández').toContain('Hernández');
  expect('Omar Hernández').toMatch(/Hernández/);
});

test('List / arrays', () => {
  const numbers = [1, 2, 3, 4, 5];
  expect(numbers).toContain(3);
});
