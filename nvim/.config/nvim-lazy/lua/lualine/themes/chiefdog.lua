local colors = {
  black = "#121212",
  white = "#ffffff",
  red = "#ff7676",
  green = "#8ec772",
  blue = "#a5adce",
  yellow = "#d9ba73",
  lightgray = "#b3b3b3",
  gray = "#666666",
  darkgrey = "#272727",
}
return {
  normal = {
    a = { bg = colors.darkgrey, fg = colors.lightgray },
    b = { bg = colors.black, fg = colors.lightgray },
    c = { bg = colors.black, fg = colors.lightgray },
    z = { bg = colors.black, fg = colors.lightgray },
  },
  insert = {
    a = { bg = colors.blue, fg = colors.black },
    b = { bg = colors.black, fg = colors.lightgray },
    c = { bg = colors.black, fg = colors.lightgray },
  },
  visual = {
    a = { bg = colors.yellow, fg = colors.black },
    b = { bg = colors.black, fg = colors.lightgray },
    c = { bg = colors.black, fg = colors.lightgray },
  },
  replace = {
    a = { bg = colors.red, fg = colors.black },
    b = { bg = colors.black, fg = colors.lightgray },
    c = { bg = colors.black, fg = colors.lightgray },
  },
  command = {
    a = { bg = colors.green, fg = colors.black },
    b = { bg = colors.black, fg = colors.lightgray },
    c = { bg = colors.black, fg = colors.lightgray },
  },
  inactive = {
    a = { bg = colors.darkgrey, fg = colors.lightgray },
    b = { bg = colors.black, fg = colors.lightgray },
    c = { bg = colors.black, fg = colors.lightgray },
  },
}
