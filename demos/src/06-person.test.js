const Person = require('./06-person');

describe('Test for Person', () => {
  let person;
  // Arrange
  beforeEach(() => {
    person = new Person('Omar', 45, 1.7);
  });

  test('should return down', () => {
    // AAA
    // Arrange // Given
    // Act // When
    // Assert // Then
    person.weight = 45;
    // Act
    const imc = person.calcIMC();
    // Assert
    expect(imc).toBe('down');
  });

  test('should return normal', () => {
    person.weight = 59;
    const imc = person.calcIMC();
    expect(imc).toBe('normal');
  });
});

