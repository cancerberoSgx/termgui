a project based on termgui for an API similar to npm.org/inquirer

```rb
inquire({
  type: 'select',
  text: 'Please choose your favorite color',
  options: [
    {value: 'green', label: 'Green'},
    {value: 'red', label: 'Red'}
  ]
}) {|color|
  p "Color answer is: #{color}"
}
```