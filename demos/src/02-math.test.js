// eslint-env jest
import { test, expect, describe } from '@jest/globals';
import {sum, multiply, divide} from './02-math.js';

describe('Test for math', () => {
    describe('test for sum', () => {
      test('adds 1 + 3 to equal 4', () => {
      const rta = sum(1, 3);
      expect(rta).toBe(4);
    });
  });

      describe('test for multiplies', () => {
      test('multiplies 2 * 3 to equal 6', () => {
      const rta = multiply(2, 3);
      expect(rta).toBe(6);
    });

  });
  describe('test for divide', () => {
    test('divides 6 / 3 to equal 2', () => {
      const rta = divide(6, 3);
      expect(rta).toBe(2);
    });
  });
});
