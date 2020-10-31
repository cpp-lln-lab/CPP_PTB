% (C) Copyright 2020 CPP_PTB developpers

function templateFunctionExample()
  % This function illustrates a documentation test defined for MOdox.
  % Other than that it does absolutely nothinghort description of what
  % the function does goes here.
  %
  % Examples:
  %   a=2;
  %   disp(a)
  %   % Expected output is prefixed by '%||' as in the following line:
  %   %|| 2
  %   %
  %   % The test continues because no interruption through whitespace,
  %   % as the previous line used a '%' comment character;
  %   % thus the 'a' variable is still in the namespace and can be
  %   % accessed.
  %   b=3+a;
  %   disp(a+[3 4])
  %   %|| [5 6]
  %
  %   % A new test starts here because the previous line was white-space
  %   % only. Thus the 'a' and 'b' variables are not present here anymore.
  %   % The following expression raises an error because the 'b' variable
  %   % is not defined (and does not carry over from the previous test).
  %   % Because the expected output indicates an error as well,
  %   % the test passes
  %   disp(b)
  %   %|| error('Some error')
  %
  %   % A set of expressions is ignored if there is no expected output
  %   % (that is, no lines starting with '%||').
  %   % Thus, the following expression is not part of any test,
  %   % and therefore does not raise an error.
  %   error('this is never executed)
  %
  %
  % % tests end here because test indentation has ended

  % The code goes below

end
