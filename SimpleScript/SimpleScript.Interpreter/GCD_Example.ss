Begin
Dim $a As int
Dim $b As int
Dim $t As int

Print "Welcome To GCD !!!"

Print "Input a:"
Input $a
Print "Input b:"
Input $b

While ($b!=0) Do
$t=$b
$b=$a % $b
$a=$t
Next
Print "The GCD is:"
Print $a
End