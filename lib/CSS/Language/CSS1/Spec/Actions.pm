use v6;
#  -- DO NOT EDIT --
# generated by gen-properties.pl --class=CSS::Language::CSS1::Spec::Actions etc/css1-properties.txt
class CSS::Language::CSS1::Spec::Actions {

    #= font-family: [[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]
    method decl:sym<font-family>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-font-family($/) { make $.list($/) }

    #= font-style: normal | italic | oblique
    method decl:sym<font-style>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-font-style($/) { make $.list($/) }

    #= font-variant: normal | small-caps
    method decl:sym<font-variant>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-font-variant($/) { make $.list($/) }

    #= font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
    method decl:sym<font-weight>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-font-weight($/) { make $.list($/) }

    #= font-size: <absolute-size> | <relative-size> | <length> | <percentage>
    method decl:sym<font-size>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-font-size($/) { make $.list($/) }

    #= font: [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family'
    method decl:sym<font>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-font($/) { make $.list($/) }

    #= color: <color>
    method decl:sym<color>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-color($/) { make $.list($/) }

    #= background-color: <color> | transparent
    method decl:sym<background-color>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-background-color($/) { make $.list($/) }

    #= background-image: <uri> | none
    method decl:sym<background-image>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-background-image($/) { make $.list($/) }

    #= background-repeat: repeat | repeat-x | repeat-y | no-repeat
    method decl:sym<background-repeat>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-background-repeat($/) { make $.list($/) }

    #= background-attachment: scroll | fixed
    method decl:sym<background-attachment>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-background-attachment($/) { make $.list($/) }

    #= background-position: [<percentage> | <length>]{1,2} | [top | center | bottom] || [left | center | right]
    method decl:sym<background-position>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-background-position($/) { make $.list($/) }

    #= background: 'background-color' || 'background-image' || 'background-repeat' || 'background-attachment' || 'background-position'
    method decl:sym<background>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-background($/) { make $.list($/) }

    #= word-spacing: normal | <length>
    method decl:sym<word-spacing>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-word-spacing($/) { make $.list($/) }

    #= letter-spacing: normal | <length>
    method decl:sym<letter-spacing>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-letter-spacing($/) { make $.list($/) }

    #= text-decoration: none | [ underline || overline || line-through || blink ]
    method decl:sym<text-decoration>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-text-decoration($/) { make $.list($/) }

    #= vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage>
    method decl:sym<vertical-align>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-vertical-align($/) { make $.list($/) }

    #= text-transform: capitalize | uppercase | lowercase | none
    method decl:sym<text-transform>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-text-transform($/) { make $.list($/) }

    #= text-align: left | right | center | justify
    method decl:sym<text-align>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-text-align($/) { make $.list($/) }

    #= text-indent: <length> | <percentage>
    method decl:sym<text-indent>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-text-indent($/) { make $.list($/) }

    #= line-height: normal | <number> | <length> | <percentage>
    method decl:sym<line-height>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-line-height($/) { make $.list($/) }

    #= margin-top: <length> | <percentage> | auto
    method decl:sym<margin-top>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-margin-top($/) { make $.list($/) }

    #= margin-right: <length> | <percentage> | auto
    method decl:sym<margin-right>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-margin-right($/) { make $.list($/) }

    #= margin-bottom: <length> | <percentage> | auto
    method decl:sym<margin-bottom>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-margin-bottom($/) { make $.list($/) }

    #= margin-left: <length> | <percentage> | auto
    method decl:sym<margin-left>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-margin-left($/) { make $.list($/) }

    #= margin: [ <length> | <percentage> | auto ]{1,4}
    method decl:sym<margin>($/) { make $.decl($/, &?ROUTINE.WHY, :boxed) }
    method expr-margin($/) { make $.list($/) }

    #= padding-top: <length> | <percentage>
    method decl:sym<padding-top>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-padding-top($/) { make $.list($/) }

    #= padding-right: <length> | <percentage>
    method decl:sym<padding-right>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-padding-right($/) { make $.list($/) }

    #= padding-bottom: <length> | <percentage>
    method decl:sym<padding-bottom>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-padding-bottom($/) { make $.list($/) }

    #= padding-left: <length> | <percentage>
    method decl:sym<padding-left>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-padding-left($/) { make $.list($/) }

    #= padding: [ <length> | <percentage> ]{1,4}
    method decl:sym<padding>($/) { make $.decl($/, &?ROUTINE.WHY, :boxed) }
    method expr-padding($/) { make $.list($/) }

    #= border-top-width: thin | medium | thick | <length>
    method decl:sym<border-top-width>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-border-top-width($/) { make $.list($/) }

    #= border-right-width: thin | medium | thick | <length>
    method decl:sym<border-right-width>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-border-right-width($/) { make $.list($/) }

    #= border-bottom-width: thin | medium | thick | <length>
    method decl:sym<border-bottom-width>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-border-bottom-width($/) { make $.list($/) }

    #= border-left-width: thin | medium | thick | <length>
    method decl:sym<border-left-width>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-border-left-width($/) { make $.list($/) }

    #= border-width: [thin | medium | thick | <length>]{1,4}
    method decl:sym<border-width>($/) { make $.decl($/, &?ROUTINE.WHY, :boxed) }
    method expr-border-width($/) { make $.list($/) }

    #= border-color: <color>{1,4}
    method decl:sym<border-color>($/) { make $.decl($/, &?ROUTINE.WHY, :boxed) }
    method expr-border-color($/) { make $.list($/) }

    #= border-style: [ none | dotted | dashed | solid | double | groove | ridge | inset | outset ]{1,4}
    method decl:sym<border-style>($/) { make $.decl($/, &?ROUTINE.WHY, :boxed) }
    method expr-border-style($/) { make $.list($/) }

    #= border-top: 'border-top-width' || 'border-style' || <color>
    method decl:sym<border-top>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-border-top($/) { make $.list($/) }

    #= border-right: 'border-right-width' || 'border-style' || <color>
    method decl:sym<border-right>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-border-right($/) { make $.list($/) }

    #= border-bottom: 'border-bottom-width' || 'border-style' || <color>
    method decl:sym<border-bottom>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-border-bottom($/) { make $.list($/) }

    #= border-left: 'border-left-width' || 'border-style' || <color>
    method decl:sym<border-left>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-border-left($/) { make $.list($/) }

    #= border: 'border-width' || 'border-style' || <color>
    method decl:sym<border>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-border($/) { make $.list($/) }

    #= width: <length> | <percentage> | auto
    method decl:sym<width>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-width($/) { make $.list($/) }

    #= height: <length> | auto
    method decl:sym<height>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-height($/) { make $.list($/) }

    #= float: left | right | none
    method decl:sym<float>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-float($/) { make $.list($/) }

    #= clear: none | left | right | both
    method decl:sym<clear>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-clear($/) { make $.list($/) }

    #= display: block | inline | list-item | none
    method decl:sym<display>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-display($/) { make $.list($/) }

    #= white-space: normal | pre | nowrap
    method decl:sym<white-space>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-white-space($/) { make $.list($/) }

    #= list-style-type: disc | circle | square | decimal | lower-roman | upper-roman | lower-alpha | upper-alpha | none
    method decl:sym<list-style-type>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-list-style-type($/) { make $.list($/) }

    #= list-style-image: <uri> | none
    method decl:sym<list-style-image>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-list-style-image($/) { make $.list($/) }

    #= list-style-position: inside | outside
    method decl:sym<list-style-position>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-list-style-position($/) { make $.list($/) }

    #= list-style: 'list-style-type' || 'list-style-image' || 'list-style-position'
    method decl:sym<list-style>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-list-style($/) { make $.list($/) }

    #= position: absolute | relative | static
    method decl:sym<position>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-position($/) { make $.list($/) }

    #= left: <length> | <percentage> | auto
    method decl:sym<left>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-left($/) { make $.list($/) }

    #= top: <length> | <percentage> | auto
    method decl:sym<top>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-top($/) { make $.list($/) }

    #= overflow: none | clip | scroll
    method decl:sym<overflow>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-overflow($/) { make $.list($/) }

    #= z-index: auto | <integer>
    method decl:sym<z-index>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-z-index($/) { make $.list($/) }

    #= visibility: inherit | visible | hidden
    method decl:sym<visibility>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-visibility($/) { make $.list($/) }

    #= page-break-before: auto | allways | left | right
    method decl:sym<page-break-before>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-page-break-before($/) { make $.list($/) }

    #= page-break-after: auto | allways | left | right
    method decl:sym<page-break-after>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-page-break-after($/) { make $.list($/) }

    #= size: <length>{1,2} | auto | portrait | landscape
    method decl:sym<size>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-size($/) { make $.list($/) }

    #= marks: crop || cross | none
    method decl:sym<marks>($/) { make $.decl($/, &?ROUTINE.WHY) }
    method expr-marks($/) { make $.list($/) }
}