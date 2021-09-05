This fixture tests the `normalize_input` function, which is responsible for
converting various flag notations to a standard one.

| Special Notation  | Normalized Noptation | Notes
|-------------------|----------------------|-------
| -abc              | -a -b -c             |
| -123              | -1 -2 -3             |
| --arg=value       | --arg value          |
| --Arg1=value      | --Arg1 value         |
| -a=v              | -a v                 |
| -1=v              | -1 v                 |
| -a=k=v            | -a k=v               | k=v is passed in a value
| --arg=key=value   | --arg key=value      | key=value is passed in as a value
| --long-arg=value  | --long-arg value     | 
| --long_arg=value  | --long_arg value     | 

Flag names should support [a-zA-Z0-9\_\-]

