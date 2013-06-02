use v6;

use CSS::Language::Actions;
use CSS::Grammar::Actions;

class CSS::Language::CSS21::Actions
    is CSS::Language::Actions {

    method color:sym<system>($/) { make $.node($/) }

    # --- Functions --- #

    method any-function($/)             {
        $.warning('ignoring function', $<ident>.ast.lc);
    }

    method attr($/)             {
        return $.warning('usage: attr( attribute-name <type-or-unit>? )')
            if $<any-args>;
        make $.node($/);
    }

    method counter($/) {
        return $.warning('usage: counter(ident [, ident [,...] ])')
            if $<any-args>;
        make $.list($/);
    }

    method counters($/) {
        return $.warning('usage: counters(ident [, "string"])')
            if $<any-args>;
        make $.node($/);
    }

    method shape-arg($/) { make $.node($/) }
    method shape($/)     {
        return $.warning('usage: rect(<top>, <right>, <botom>, <left>)')
            if $<any-args>;
        make $.node($/);
    }

    # experimental rule
    method val($/) { make $.list($<expr> // $/) }

   # --- Properties --- #

    # - azimuth: <angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards | inherit
    method azimuth($/) {
        my %ast = $.node($/);

        # compute implied angles
        my $implied;
        my $direction = %ast<direction> || %ast<behind>;

        if $direction {

            state %angles = (
                'left-side'    => [270, 270],
                'far-left'     => [300, 240],
                'left'         => [320, 220],
                'center-left'  => [340, 200],
                'center'       => [0,   180],
                'center-right' => [20,  160],
                'right'        => [40,  140],
                'far-right'    => [60,  120],
                'right-side'   => [90,  90],
                'behind'       => [180, 180],
                );

            my $bh = %ast<behind> ?? 1 !! 0;

            $implied = (angle => $.token(%angles{$direction}[$bh], :type<angle>, :units<degrees> ));
            }
        elsif %ast<delta> {
            my $delta_angle = %ast<delta> eq 'leftwards' ?? -20 !! 20;
            $implied = (delta => $.token($delta_angle, :type<angle>, :units<degrees> ));
        }

        %ast<_implied> = $implied
            if $implied;

        make %ast;
    }

    method decl:sym<azimuth>($/) {
        # see http://www.w3.org/TR/2011/REC-CSS2-20110607/aural.html
        make $._decl($0, $<val>, 'usage azimuth: <angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards | inherit');
    }

    # - background-attachment: scroll | fixed | inherit
    method background-attachment($/) { make $.list($/) }
    method decl:sym<background-attachment>($/) {
        make $._decl($0, $<val>, 'scroll | fixed | inherit');
    };

    # - background-color: <color> | transparent | inherit
    method background-color($/) { make $.list($/) }
    method decl:sym<background-color>($/) {
        make $._decl($0, $<val>, '<color> | transparent | inherit')
    };

    # - background-image: <url> | none | inherit
    method background-image($/) { make $.list($/) }
    method decl:sym<background-image>($/) {
        make $._decl($0, $<val>, '<uri> | none | inherit')
    };

    # - background-position: [ [ <percentage> | <length> | left | center | right ] [ <percentage> | <length> | top | center | bottom ]? ] | [ [ left | center | right ] || [ top | center | bottom ] ] | inherit
    # refactored as [ <percentage> | <length> | left | center | right ] || [ <percentage> | <length> | top | center | bottom ] | inherit
    method position($/) { make $.list($/) }
    method decl:sym<background-position>($/) {
        make $._decl($0, $<val>, q{[ <percentage> | <length> | left | center | right ] || [ <percentage> | <length> | top | center | bottom ] | inherit});
    }

    # - background-repeat: repeat | repeat-x | repeat-y | no-repeat
    method background-repeat($/) { make $.list($/) }
    method decl:sym<background-repeat>($/) {
        make $._decl($0, $<val>, 'repeat | repeat-x | repeat-y | no-repeat | inherit')
    };

    # - background: <background-color> || <background-image> || <background-repeat> || <background-attachment> || <background-position> | inherit
     method decl:sym<background>($/) {
        make $._decl($0, $<val>, q{['background-color' || 'background-image' || 'background-repeat' || 'background-attachment' || 'background-position'] | inherit});
    }

    # - border-collapse: collapse | separate | inherit
    method decl:sym<border-collapse>($/) {
        make $._decl($0, $<val>, q{collapse | separate | inherit});
    }

    # - border-color: [ <color> | transparent ]{1,4} | inherit
    method border-color($/) { make $.list($/) }
    method decl:sym<border-color>($/) {
        make $._decl($0, $<val>, q{[ <color> | transparent ]{1,4} | inherit},
                     :expand<box>);
    }
    
    # - border-spacing: <length> <length>? | inherit
    method decl:sym<border-spacing>($/) {
        make $._decl($0, $<val>, q{<length> <length>? | inherit});
    }

    # - border-top|border-right|border-bottom|border-left: [ <border-width> || <border-style> || 'border-top-color' ] | inherit
    method decl:sym<border-*>($/) {
        make $._decl($0, $<val>, q{[ <border-width> || <border-style> || 'border-color' ] | inherit});
    }

    # - border-top-color|border-right-color|border-bottom-color|border-left-color: <color> | transparent | inherit
    method decl:sym<border-*-color>($/) {
        make $._decl($0, $<val>, q{<color> | transparent | inherit});
    }

    # - border-top-style|border-right-style|border-bottom-style|border-left-style: <border-style> | inherit
    method decl:sym<border-*-style>($/) {
        make $._decl($0, $<val>, q{<border-style> | inherit});
    }

    # - border-style: [ none | hidden | dotted | dashed | solid | double | groove | ridge | inset | outset ]{1,4}
    method border-style($/) { make $.list($/) }
    method decl:sym<border-style>($/) {
        make $._decl($0, $<val>, 'none | dotted | dashed | solid | double | groove | ridge | inset | outset | inherit', :expand<box>);
    }

    # - border-top-width|border-right-width|border-bottom-width|border-left-width: <border-width> | inherit
    method decl:sym<border-*-width>($/) {
        make $._decl($0, $<val>, q{<border-width> | inherit});
    }

    # - border-width: <border-width>{1,4} | inherit
    method border-width($/) { make $.list($/) }
    method decl:sym<border-width>($/) {
        make $._decl($0, $<val>, q{<border-width>{1,4} | inherit},
                     :expand<box>);
    }

    # border_width: thin | medium | thick | <length>  -- inherited
    method decl:sym<border>($/) {
        make $._decl($0, $<val>, q{[ <border-width> || <border-style> || 'border-top-color' ] | inherit});
    }

    # - bottom: <length> | <percentage> | auto | inherit
    method decl:sym<bottom>($/) {
        make $._decl($0, $<val>, q{<length> | <percentage> | auto | inherit});
    }

    # - caption-side: top | bottom | inherit
    method decl:sym<caption-side>($/) {
        make $._decl($0, $<val>, q{top | bottom | inherit});
    }

    # - clear: none | left | right | both | inherit
    method decl:sym<clear>($/) {
        make $._decl($0, $<val>, 'none | left | right | none');
    }

    # - clip: <shape> | auto
    method decl:sym<clip>($/) {
        make $._decl($0, $<val>, ' <shape> | auto | inehrit');
    }

    # - color: <color> | inherit
    method decl:sym<color>($/) {
        make $._decl($0, $<val>, '<color> | inherit');
    }

    # - content: normal | none | [ <string> | <uri> | <counter> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+ | inherit
    method decl:sym<content>($/) {
        make $._decl($0, $<val>, q{normal | none | [ <string> | <uri> | <counter> | attr(<identifier>) | open-quote | close-quote | no-open-quote | no-close-quote ]+ | inherit});
    }

    # - counter-increment: [ <identifier> <integer>? ]+ | none | inherit
    # - counter-reset: [ <identifier> <integer>? ]+ | none | inherit
    method decl:sym<counter-[increment|reset]>($/) {
        make $._decl($0, $<val>, q{[ <identifier> <integer>? ]+ | none | inherit});
    }

    method cue($/) { make $.list($/) }
    # - cue-before: <uri> | none | inherit
    # - cue-after: <uri> | none | inherit
    method decl:sym<cue-[before|after]>($/) {
        make $._decl($0, $<val>, q{<uri> | none | inherit});
    }

    # - cue: [ 'cue-before' || 'cue-after' ] | inherit
    method decl:sym<cue>($/) {
        make $._decl($0, $<val>, q{[ 'cue-before' || 'cue-after' ] | inherit});
    }

    # - cursor: [ [<uri> ,]* [ auto | crosshair | default | pointer | move | e-resize | ne-resize | nw-resize | n-resize | se-resize | sw-resize | s-resize | w-resize | text | wait | help | progress ] ] | inherit
    method decl:sym<cursor>($/) {
        make $._decl($0, $<val>, q{[ [<uri> ,]* [ auto | crosshair | default | pointer | move | e-resize | ne-resize | nw-resize | n-resize | se-resize | sw-resize | s-resize | w-resize | text | wait | help | progress ] ] | inherit});
    }

    # - direction: ltr | rtl | inherit
    method decl:sym<direction>($/) {
        make $._decl($0, $<val>, q{ltr | rtl | inherit});
    }

    # - display: inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none | inherit
    method decl:sym<display>($/) {
        make $._decl($0, $<val>, q{inline | block | list-item | inline-block | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none | inherit});
    }

    method elevation($/) {
        my %ast = $.node($/);

        my $direction = %ast<direction>;
        my $implied;

        if $direction {

            state %angles = (
                'below'    => -90,
                'level'    =>   0,
                'above'    =>  90,
                );

            $implied = (angle => $.token(%angles{$direction}, :type<angle>, :units<degrees> ));
        }
        elsif %ast<tilt> {
            my $delta_angle = %ast<tilt> eq 'lower' ?? -10 !! 10;
            $implied = (delta => $.token($delta_angle, :type<angle>, :units<degrees> ));
        }

        %ast<_implied> = $implied
            if $implied;

        make %ast;
    }

    # - elevation: <angle> | below | level | above | higher | lower | inherit
    method decl:sym<elevation>($/) {
        # see http://www.w3.org/TR/2011/REC-CSS2-20110607/aural.html
        make $._decl($0, $<val>, '<angle> | below | level | above | higher | lower | inherit');

    }

    # - empty-cells: show | hide | inherit
    method decl:sym<empty-cells>($/) {
        make $._decl($0, $<val>, q{show | hide | inherit});
    }

    # - float: left | right | none | inherit
    method decl:sym<float>($/) {
        make $._decl($0, $<val>, 'left | right | none');
    }

    # - font-family: [[ <family-name> | <generic-family> ] [, <family-name> | <generic-family> ]* ] | inherit
    method font-family($/) { make $.list($/) }
    method decl:sym<font-family>($/) {
        make $._decl($0, $<val>, '[[<family-name> | <generic-family>],]* [<family-name> | <generic-family>]');
    }

    # - font-size: <absolute-size> | <relative-size> | <length> | <percentage> | inherit
    method absolute-size($/) { make $.token($<keyw>.ast) }
    method relative-size($/) { make $.token($<keyw>.ast) }
    method font-size($/)     { make $.list($/) }
    method decl:sym<font-size>($/) {
        make $._decl($0, $<val>, '[[x]x-]small | medium | [[x]x\-]large | larger | smaller | <length> | <percentage>');
    }

    # - font-style: normal | italic | oblique | inherit
    method font-style($/) { make $.node($/) }
    method decl:sym<font-style>($/) {
        make $._decl($0, $<val>, 'normal | italic | oblique');
    }

    # - font-variant: normal | small-caps | inherit
    method font-variant($/) { make $.node($/) }
    method decl:sym<font-variant>($/) {
        make $._decl($0, $<val>, 'normal | small-caps');
    }

    # - font-weight: normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 | inherit
    method font-weight($/) { make $.node($/) }
    method decl:sym<font-weight>($/) {
        make $._decl($0, $<val>, 'normal | bold | bolder | lighter | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900'); 
    }

    # - font: [ [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family' ] | caption | icon | menu | message-box | small-caption | status-bar | inherit
    method decl:sym<font>($/) {
        make $._decl($0, $<val>, q{[ [ 'font-style' || 'font-variant' || 'font-weight' ]? 'font-size' [ / 'line-height' ]? 'font-family' ] | caption | icon | menu | message-box | small-caption | status-bar | inherit});
    }

    # - width: <length> | <percentage> | auto | inherit
    # - height: <length> | <percentage> | auto | inherit
    # - left: <length> | <percentage> | auto | inherit
    # - right: <length> | <percentage> | auto | inherit
    method decl:sym<width|height|left|top>($/) {
        make $._decl($0, $<val>, '<length> | <percentage> | auto');
    }

    # - letter-spacing: normal | <length>
    # - word-spacing: normal | <length>
    method decl:sym<*-spacing>($/) {
        make $._decl($0, $<val>, 'normal | <length>');
    }

    # - line-height: normal | <number> | <length> | <percentage> | inherit
    method line-height($/) { make $.list($/); }
    method decl:sym<line-height>($/) {
        make $._decl($0, $<val>, 'normal | <number> | <length> | <percentage>');
    }

    # - list-style-image: <uri> | none | inherit
    method list-style-image($/) { make $.list($/) }
    method decl:sym<list-style-image>($/) {
        make $._decl($0, $<val>, q{<uri> | none | inherit});
    }

    # - list-style-position: inside | outside | inherit
    method list-style-position($/) { make $.list($/) }
    method decl:sym<list-style-position>($/) {
        make $._decl($0, $<val>, 'inside | outside | inherited');
    }

    # - list-style-type: disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none | inherit
    method list-style-type($/) { make $.list($/) }
    method decl:sym<list-style-type>($/) {
        make $._decl($0, $<val>, q{disc | circle | square | decimal | decimal-leading-zero | lower-roman | upper-roman | lower-greek | lower-latin | upper-latin | armenian | georgian | lower-alpha | upper-alpha | none | inherit});
    }

    # - list-style: [ 'list-style-type' || 'list-style-position' || 'list-style-image' ] | inherit
    method decl:sym<list-style>($/) {
        make $._decl($0, $<val>, q{[ 'list-style-type' || 'list-style-position' || 'list-style-image' ] | inherit});
    }

    # - margin-right|margin-left: <margin-width> | inherit
    # - margin-top|margin-bottom: <margin-width> | inherit
    method margin-width($/) { make $.list($/) }
    method decl:sym<margin-*>($/) {
        make $._decl($0, $<val>, q{<margin-width> | inherit});
    }

    # - margin: <margin-width>{1,4} | inherit
    method decl:sym<margin>($/) {
        make $._decl($0, $<val>, q{<margin-width>{1,4} | inherit},
                     :expand<box>);
    }

    # - max-height: <length> | <percentage> | none | inherit
    # - max-width: <length> | <percentage> | none | inherit
    method decl:sym<max-[width|height]>($/) {
        make $._decl($0, $<val>, q{<length> | <percentage> | none | inherit});
    }

    # - min-height: <length> | <percentage> | inherit
    # - min-width: <length> | <percentage> | inherit
    method decl:sym<min-[width|height]>($/) {
        make $._decl($0, $<val>, q{<length> | <percentage> | inherit});
    }

    # - orphans: <integer> | inherit
    method decl:sym<orphans>($/) {
        make $._decl($0, $<val>, q{<integer> | inherit});
    }

    # - outline-color: <color> | invert | inherit
    method outline-color($/) { make $.list($/) }
    method decl:sym<outline-color>($/) {
        make $._decl($0, $<val>, q{<color> | invert | inherit});
    }

    # - outline-style: <border-style> | inherit
    method decl:sym<outline-style>($/) {
        make $._decl($0, $<val>, q{<border-style> | inherit});
    }

    # - outline-width: <border-width> | inherit
    method decl:sym<outline-width>($/) {
        make $._decl($0, $<val>, q{<border-width> | inherit});
    }

    # - outline: [ 'outline-color' || 'outline-style' || 'outline-width' ] | inherit
    method decl:sym<outline>($/) {
        make $._decl($0, $<val>, q{[ 'outline-color' || 'outline-style' || 'outline-width' ] | inherit});
    }

    # - overflow: visible | hidden | scroll | auto | inherit
    method decl:sym<overflow>($/) {
        make $._decl($0, $<val>, q{visible | hidden | scroll | auto | inherit});
    }

    method padding-width($/) { make $.list($/) }
    # - padding-top|padding-right|padding-bottom|padding-left: <padding-width> | inherit
    method decl:sym<padding-*>($/) {
        make $._decl($0, $<val>, q{<padding-width> | inherit});
    }

    # - padding: <padding-width>{1,4} | inherit
     method decl:sym<padding>($/) {
        make $._decl($0, $<val>, q{<padding-width>{1,4} | inherit},
                     :expand(<box>));
    }

    # - page-break-after: auto | always | avoid | left | right | inherit
    # - page-break-before: auto | always | avoid | left | right | inherit
    method decl:sym<page-break-[before|after]>($/) {
        make $._decl($0, $<val>, q{auto | always | avoid | left | right | inherit});
    }

    # - page-break-inside: avoid | auto | inherit
    method decl:sym<page-break-inside>($/) {
        make $._decl($0, $<val>, q{avoid | auto | inherit});
    }

    method pause($/) { make $.list($/) }
    # - pause-after: <time> | <percentage> | inherit
    # - pause-before: <time> | <percentage> | inherit
    method decl:sym<pause-[before|after]>($/) {
        make $._decl($0, $<val>, q{<time> | <percentage> | inherit});
    }

    # - pause: [ [<time> | <percentage>]{1,2} ] | inherit
    method decl:sym<pause>($/) {
        make $._decl($0, $<val>, q{[ [<time> | <percentage>]{1,2} ] | inherit});
    }

    # - pitch-range: <number> | inherit
    method decl:sym<pitch-range>($/) {
        make $._decl($0, $<val>, q{<number> | inherit});
    }

    # - pitch: <frequency> | x-low | low | medium | high | x-high | inherit
    method decl:sym<pitch>($/) {
        make $._decl($0, $<val>, q{<frequency> | x-low | low | medium | high | x-high | inherit});
    }

    # - play-during: <uri> [ mix || repeat ]? | auto | none | inherit
    method decl:sym<play-during>($/) {
        make $._decl($0, $<val>, q{<uri> [ mix || repeat ]? | auto | none | inherit});
    }

    # - position: static | relative | absolute | fixed | inherit
    method decl:sym<position>($/) {
        make $._decl($0, $<val>, q{static | relative | absolute | fixed | inherit});
    }

    # - quotes: [<string> <string>]+ | none | inherit
    method decl:sym<quotes>($/) {
        make $._decl($0, $<val>, q{[<string> <string>]+ | none | inherit});
    }

    # - richness: <number> | inherit
    method decl:sym<richness>($/) {
        make $._decl($0, $<val>, q{<number> | inherit});
    }

    # - right: <length> | <percentage> | auto | inherit
    method decl:sym<right>($/) {
        make $._decl($0, $<val>, q{<length> | <percentage> | auto | inherit});
    }

    # - size: <length>{1,2} | auto | portrait | landscape | inherit
    method decl:sym<size>($/) {
        make $._decl($0, $<val>, '<length>{1,2} | auto | portrait | landscape');
    }

    # - speak-header: once | always | inherit
    method decl:sym<speak-header>($/) {
        make $._decl($0, $<val>, q{once | always | inherit});
    }

    # - speak-numeral: digits | continuous | inherit
    method decl:sym<speak-numeral>($/) {
        make $._decl($0, $<val>, q{digits | continuous | inherit});
    }

    # - speak-punctuation: code | none | inherit
     method decl:sym<speak-punctuation>($/) {
        make $._decl($0, $<val>, q{code | none | inherit});
    }

    # - speak: normal | none | spell-out | inherit
    method decl:sym<speak>($/) {
        make $._decl($0, $<val>, q{normal | none | spell-out | inherit});
    }

    # - speech-rate: <number> | x-slow | slow | medium | fast | x-fast | faster | slower | inherit
    method decl:sym<speech-rate>($/) {
        make $._decl($0, $<val>, q{<number> | x-slow | slow | medium | fast | x-fast | faster | slower | inherit});
    }

    # - stress: <number> | inherit
    method decl:sym<stress>($/) {
        make $._decl($0, $<val>, q{<number> | inherit});
    }

    # - table-layout: auto | fixed | inherit
    method decl:sym<table-layout>($/) {
        make $._decl($0, $<val>, q{auto | fixed | inherit});
    }

    # - text-align: left | right | center | justify | inherit
    method decl:sym<text-align>($/) {
        make $._decl($0, $<val>, 'left | right | center | justify | inherit');
    }

    # - text-decoration: none | [ underline || overline || line-through || blink ] | inherit
    method decl:sym<text-decoration>($/) {
        make $._decl($0, $<val>, 'none | [ underline || overline || line-through || blink ]');
    }

    # - text-indent: <length> | <percentage> | inherit
    method decl:sym<text-indent>($/) {
        make $._decl($0, $<val>, '<length> | <percentage>');
    }

    # - text-transform: capitalize | uppercase | lowercase | none | inherit
    method decl:sym<text-transform>($/) {
        make $._decl($0, $<val>, 'capitalize | uppercase | lowercase | none');
    }

    # - unicode-bidi: normal | embed | bidi-override | inherit
    method decl:sym<unicode-bidi>($/) {
        make $._decl($0, $<val>, q{normal | embed | bidi-override | inherit});
    }

    # - vertical-align: baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage> | <length> | inherit
    method decl:sym<vertical-align>($/) {
        make $._decl($0, $<val>, q{baseline | sub | super | top | text-top | middle | bottom | text-bottom | <percentage> | <length> | inherit});
    }

    # - visibility: visible | hidden | collapse | inherit
    method decl:sym<visibility>($/) {
        make $._decl($0, $<val>, q{visible | hidden | collapse | inherit});
    }

    # - voice-family: [[<specific-voice> | <generic-voice> ],]* [<specific-voice> | <generic-voice> ] | inherit
    method generic-voice($/) { make $.list($/) }
    method specific-voice($/) { make $.list($/) }
    method decl:sym<voice-family>($/) {
        make $._decl($0, $<val>, q{[[<specific-voice> | <generic-voice> ],]* [<specific-voice> | <generic-voice> ] | inherit});
    }

    # - volume: <number> | <percentage> | silent | x-soft | soft | medium | loud | x-loud | inherit
    method decl:sym<volume>($/) {
        make $._decl($0, $<val>, q{<number> | <percentage> | silent | x-soft | soft | medium | loud | x-loud | inherit});
    }

    # - white-space: normal | pre | nowrap | pre-wrap | pre-line | inherit
    method decl:sym<white-space>($/) {
        make $._decl($0, $<val>, q{normal | pre | nowrap | pre-wrap | pre-line | inherit});
    }

    # - widows: <integer> | inherit
    method decl:sym<widows>($/) {
        make $._decl($0, $<val>, q{<integer> | inherit});
    }

    # - z-index: auto | <integer> | inherit
    method decl:sym<z-index>($/) {
        make $._decl($0, $<val>, 'auto | <integer>');
    }

}
