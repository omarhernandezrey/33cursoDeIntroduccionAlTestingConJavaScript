// eslint-env jest
import { test, expect } from '@jest/globals';
import {sum, multiply, divide} from './02-math.js';

test('adds 1 + 3 to equal 4', () => {
  const rta = sum(1, 3);
  expect(rta).toBe(4);
});

test('multiplies 2 * 3 to equal 6', () => {
  const rta = multiply(2, 3);
  expect(rta).toBe(6);
});

test('divides 6 / 2 to equal 3', () => {
  const rta = divide(6, 2);
  expect(rta).toBe(3);
});
