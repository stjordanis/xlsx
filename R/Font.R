######################################################################
# Deal with Fonts
is.Font <- function(x) inherits(x, "Font")


######################################################################
# 
createFont <- function(...) {
  warning("DEPRECATED.  Use Font.  To be removed in version 0.5.0.")
  Font(...)
}


######################################################################
# Create a Font.  It needs a workbook object!
#  - color is an R color string.
#
Font <- function(wb, color=NULL, fontHeightInPoints=NULL, fontName=NULL,
  isItalic=FALSE, isStrikeout=FALSE, isBold=FALSE, underline=NULL,
  boldweight=NULL) # , setFamily=NULL
{
  font <- .jcall(wb, "Lorg/apache/poi/ss/usermodel/Font;",
    "createFont") 

  if (!is.null(color))
    if (grepl("XSSF", wb$getClass()$getName())){ 
      .jcall(font, "V", "setColor", .xssfcolor(color))   
    } else {
      .jcall(font, "V", "setColor",
        .jshort(INDEXED_COLORS[toupper(color)]))
    }
      
  if (!is.null(fontHeightInPoints))
    .jcall(font, "V", "setFontHeightInPoints", .jshort(fontHeightInPoints))

  if (!is.null(fontName))
    .jcall(font, "V", "setFontName", fontName)

  if (isItalic)
    .jcall(font, "V", "setItalic", TRUE)

  if (isStrikeout)
    .jcall(font, "V", "setStrikeout", TRUE)

  if (isBold & grepl("XSSF", wb$getClass()$getName()))
    .jcall(font, "V", "setBold", TRUE)

  if (!is.null(underline))
    .jcall(font, "V", "setUnderline", .jbyte(underline))
  
  if (!is.null(boldweight))
    .jcall(font, "V", "setBoldweigth", .jshort(boldweight))

   structure(list(ref=font), class="Font") 
}