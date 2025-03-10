## Learn User Functions

A user function makes sense at this point, and will provide the following benefits:
- A readable name that makes the usage and understanding of the transformation formula a lot easier
- A central place to maintain the transformation code
- The ability to share the transformation logic with other developers who do not have to come up with the code for this anymore.

One need to provide 3 elements when you build a user function:
- A name (and a group name to organize the functions)
- A syntax
- The actual code to be generated when the developers will use the functions

1. Naming the function
- Let's try to build a custom trim function (just for practice). Assume that the name of the user function is `TRIM_DATA`
```txt
Under Definition
-----------------
Name: TRIM_DATA
Group: StringOperations
Syntax: TRIM_DATA($(StringData))
```
2. The User Function Syntax
- The next step will be to define the syntax for the function. Parameters are defined with a starting dollarsign: `$` and enclosed in parenthesis: `()`.
- One can name your parameters as you want: these names will be used when you put together the code for the user functions, along with the $ and ().
- One can have no parameters or as many parameters as you want.
- Implementation (this tab is used to provide the technology and the implementation of the native functions)
```txt
Implementations (Press the + symbol)
Linked Technology: Oracle
Implementation syntax: TRIM($(StringData))
```
- If you want to force the data types for the parameters, you can do so by adding the appropriate character after the parameter name: `s for String` `n for Numeric` and `d for Date`.
- In that case our User Function syntax would be:
```txt
TRIM_DATA($(StringData)s) -- In the Syntax under definition
TRIM($(StringData)s) -- In the Implementation Syntax
```
- One can use these user functions directly onto the target table or can do via the expressions table.
> [!NOTE]
> When you will execute your interface, the generated code can be reviewed in the Operator interface. Note that you should never see the function names in the generated code. If you do, check out the following elements:
> - User Function names are case sensitive. Make sure that you are using the appropriate combination of uppercase and lowercase characters
> - Make sure that you are using the appropriate number of parameters, and that they have the appropriate type (string, number or date)
> - Make sure that there is a definition for the User Function for the technology in which it is running. This last case may be the easiest one to oversee.
---
The Oracle official blog on the topic: [ODI_User_Functions](https://blogs.oracle.com/dataintegration/post/odi-user-functions-a-case-study)
