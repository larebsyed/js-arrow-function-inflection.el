# js-arrow-function-inflection.el
The package provides a couple of function to convert javascript es6 arrow function to normal functions and vice versa. 

**Motivation**

Most of time when developing a react or javascript application you realize that you need an es6 arrow function instead of simple js function. Changing a simple function to arrow function is an easy task but still one can save a few keystrokes by automating it. This package provides that automation. 

The package provides * `js-arrow-function-inflections`
It provides access to three functions

- **js-arrow-function-inflection-convert-to-arrow-function**
 
 Used to convert normal function to arrow function in javascript es6
 For further info get doc-string for this `js-arrow-function-inflection-convert-to-arrow-function'
 
  * Examples:
      - `() {} -> () => {}`
      - `function abc () {} -> const abc = () => {}`
      - `abc () {} -> abc =() => {}`
      - `function abc (x, y) {} => const abc (x, y) => {}`

- **js-arrow-function-inflection-convert-to-function**
 
 Used to convert arrow function to normal function in javascript es6
 For further info get doc-string for `js-arrow-function-inflection-convert-to-function'
 
   * Examples:
      - `() => {} -> () {}`
      - `const abc = () => {} -> function abc () {}`
      - `abc =() => {} -> abc () {}`
      - `const abc (x, y) => {} => function abc (x, y) {}`


- **js-arrow-function-inflection-toggle**
 
 Used to toggle between the two forms of function in javascript es6
