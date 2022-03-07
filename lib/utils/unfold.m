function unfold(input, varargin)
  %
  % Unfolds a structure.
  %
  % USAGE::
  %
  %   unfold(SC, varargin)
  %
  %   UNFOLD(SC) displays the content of a variable.
  %
  %   If SC is a structure it recursively shows the name of SC and the fieldnames of SC and their
  %   contents.
  %
  %   If SC is a cell array the contents of each cell are displayed.
  %
  %   It uses the caller's workspace variable name as the name of SC.
  %   UNFOLD(SC,NAME) uses NAME as the name of SC.
  %
  %   UNFOLD(SC,SHOW) If SHOW is false only the fieldnames and their sizes
  %   are  shown, if SHOW is true the contents are shown also.
  %
  % (C) Copyright 2022 Remi Gau
  % (C) Copyright 2005-2006 R.F. Tap

  % R.F. Tap
  % 15-6-2005, 7-12-2005, 5-1-2006, 3-4-2006

  % taken and adapted from shorturl.at/dqwN7

  % check input
  switch nargin
    case 1
      Name = inputname(1);
      show = true;
    case 2
      if islogical(varargin{1})
        Name = inputname(1);
        show = varargin{1};
      elseif ischar(varargin{1})
        Name = varargin{1};
        show = true;
      else
        error('Second input argument must be a string or a logical');
      end
    case 3
      if ischar(varargin{1})
        if islogical(varargin{2})
          Name = varargin{1};
          show = varargin{2};
        else
          error('Third input argument must be a logical');
        end
      else
        error('Second input argument must be a string');
      end
    otherwise
      error('Invalid number of input arguments');
  end

  if isstruct(input)

    input = orderfields(input);
    % number of elements to be displayed
    NS = numel(input);
    if show
      hmax = NS;
    else
      hmax = min(1, NS);
    end

    % recursively display structure including fieldnames
    for h = 1:hmax
      F = fieldnames(input(h));
      NF = length(F);
      for i = 1:NF

        if NS > 1
          siz = size(input);
          if show
            Namei = [Name '(' indToStr(siz, h) ').' F{i}];
          else
            Namei = [Name '(' indToStr(siz, NS) ').'  F{i}];
          end
        else
          Namei = [Name '.' F{i}];
        end

        if isstruct(input(h).(F{i}))
          unfold(input(h).(F{i}), Namei, show);
        else

          if iscell(input(h).(F{i}))
            if numel(input(h).(F{i})) == 0
              printKeyToScreen(Namei);
              fprintf(' =\t{};');
            else
              siz = size(input(h).(F{i}));
              NC = numel(input(h).(F{i}));
              if show
                jmax = NC;
              else
                jmax = 1;
              end
              for j = 1:jmax
                if show
                  Namej = [Namei '{' indToStr(siz, j) '}'];
                else
                  Namej = [Namei '{' indToStr(siz, NC) '}'];
                end
                printKeyToScreen(Namej);
                if show
                  printValueToScreen(input(h).(F{i}){j});
                end
              end
            end

          else
            printKeyToScreen(Namei);
            if show
              printValueToScreen(input(h).(F{i}));
            end
          end

        end
      end
    end

  elseif iscell(input)

    if numel(input) == 0
      fprintf(' =\t{};');
    else
      % recursively display cell
      siz = size(input);
      for i = 1:numel(input)
        Namei = [Name '{' indToStr(siz, i) '}'];
        unfold(input{i}, Namei, show);
      end
    end

  else

    printKeyToScreen(Name);
    if show
      printValueToScreen(input);
    end

  end

end

function printKeyToScreen(input)
  fprintf(sprintf('\n%s', input));
end

function printValueToScreen(input)
  base_string = ' =\t';
  msg = '';
  if ischar(input)
    msg = sprintf('%s''%s''  ', base_string, input);
  elseif isinteger(input) || islogical(input)
    if isempty(input)
      msg = ' =\t[]  ';
    else
      pattern = repmat('%i, ', 1, numel(input));
      msg = sprintf(['%s' pattern], base_string, input);
    end
  elseif isnumeric(input)
    if isempty(input)
      msg = ' =\t[]  ';
    else
      pattern = repmat('%f, ', 1, numel(input));
      msg = sprintf(['%s' pattern], base_string, input);
    end
  end
  fprintf(msg);
  fprintf('\b\b;');
end

% local functions
% --------------------------------------------------------------------------
function str = indToStr(siz, ndx)

  n = length(siz);
  % treat vectors and scalars correctly
  if n == 2
    if siz(1) == 1
      siz = siz(2);
      n = 1;
    elseif siz(2) == 1
      siz = siz(1);
      n = 1;
    end
  end
  k = [1 cumprod(siz(1:end - 1))];
  ndx = ndx - 1;
  str = '';
  for i = n:-1:1
    v = floor(ndx / k(i)) + 1;
    if i == n
      str = num2str(v);
    else
      str = [num2str(v) ',' str];
    end
    ndx = rem(ndx, k(i));
  end

end
