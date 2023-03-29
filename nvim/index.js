const reverseArray = (array) => {
  const reversedArray = [];
  for (let i = array.length - 1; i >= 0; i--) {
    reversedArray.push(array[i]);
  }
  return reversedArray;
};

const reverseArrayInPlace = (array) => {
  for (let i = 0; i < Math.floor(array.length / 2); i++) {
    const old = array[i];
    array[i] = array[array.length - 1 - i];
    array[array.length - 1 - i] = old;
  }
  return array;
};

console.log(reverseArray(["A", "B", "C"]));
