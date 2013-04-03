#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS1;
use CSS::Language::CSS1::Actions;
use lib '.';
use t::AST;

my $css_actions = CSS::Language::CSS1::Actions.new;

for (
    decl => {input => 'font-family: Gill, "Helvetica", sans-serif',   ast => {"property" => "font-family", "expr" => ["family-name" => "gill",
                                                                                                                      "family-name" => "Helvetica",
                                                                                                                      "generic-family" => "sans-serif"]},
    },
    decl => {input => 'font-style: bold', ast => {"property" => "font-style", expr => ["font-style" => 'bold']},
    },
    decl => {input => 'font-variant: small-caps', ast => {"property" => "font-variant", expr => ["font-variant" => 'small-caps']},
    },
    decl => {input => 'font-weight: bolder', ast => {"property" => "font-weight", expr => ["font-weight" => 'bolder']},
    },
    decl => {input => 'font-weight: 800', ast => {"property" => "font-weight", expr => ["font-weight" => '800']},
    },
    decl => {input => 'font-size: 12pt', ast => {"property" => "font-size", expr => [length => '12']},
    },
    decl => {input => 'font-size: 150%', ast => {"property" => "font-size", expr => [percentage => '150']},
    },
    decl => {input => 'font-size:Larger', ast => {"property" => "font-size", expr => [relative-size => 'larger']},
    },
    decl => {input => 'font: 12pt/14pt sans-serif',
             ast => {"property_list" => [{"property" => "font-size", "expr" => ["length" => 12]},
                                         {"property" => "line-height", "expr" => ["length" => 14]},
                                         {"property" => "font-family", "expr" => ["generic-family" => "sans-serif"]}]},
    },
    decl => {input => 'font: normal small-caps 120%/120% fantasy',
             ast => {"property_list" => [{"property" => "font-style", "expr" => "normal"},
                                         {"property" => "font-variant", "expr" => "small-caps"},
                                         {"property" => "font-size", "expr" => ["percentage" => 120]},
                                         {"property" => "line-height", "expr" => ["percentage" => 120]}, {"property" => "font-family", "expr" => ["generic-family" => "fantasy"]}]},
    },
    decl => {input => 'background-attachment: FiXed',   ast => {property => 'background-attachment', expr => [ident => 'fixed']},
    },
    decl => {input => 'background-color : #37a', ast => {property => 'background-color', expr => [color => {r => 0x33, g => 0x77, b => 0xAA}]},
    },
    decl => {input => 'background-image : url(images/ok.png)', ast => {property => 'background-image', expr => [url => 'images/ok.png']},
    },
    decl => {input => 'background-repeat : Repeat-x', ast => {property => 'background-repeat', expr => [ident => 'repeat-x']},
    },
    decl => {input => 'background-position : 100% 90%', ast => {"property" => "background-position", "expr" => ["percentage" => 100, "percentage" => 90]},
    },
    decl => {input => 'background: url(chess.png) gray 50% repeat scroll', 
             ast => {"property_list" => [{"property" => "background-image", "expr" => ["url" => "chess.png"]},
                                         {"property" => "background-color", "expr" => ["color" => {"r" => 128, "g" => 128, "b" => 128}]},
                                         {"property" => "background-position", "expr" => ["percentage" => 50]},
                                         {"property" => "background-repeat", "expr" => ["ident" => "repeat"]},
                                         {"property" => "background-attachment", "expr" => ["ident" => "scroll"]}]},
    },
    decl => {input => 'word-spacing:1.5em',
             ast => {"property" => "word-spacing",
                     "expr" => ["length" => 1.5]}
    },
    decl => {input => 'letter-spacing: normal',
             ast => {"property" => "letter-spacing",
                     "expr" => ["ident" => "normal"]}
    },
    decl => {input => 'text-decoration: Underline',
             ast => {"property" => "text-decoration",
                     "expr" => ["ident" => "underline"]}
    },
    decl => {input => 'vertical-align: text-top',
             ast => {"property" => "vertical-align",
                     "expr" => ["ident" => "text-top"]}

    },
    decl => {input => 'text-transform: uppercase',
             ast => {"property" => "text-transform",
                     "expr" => ["ident" => "uppercase"]}
    },
    decl => {input => 'text-align: justify',
             ast => {"property" => "text-align",
                     "expr" => ["ident" => "justify"]}
    },
    decl => {input => 'line-height: 120%',
             ast => {"property" => "line-height",
                     "expr" => ["line-height" => {"percentage" => 120}]}
    },
    decl => {input => 'margin-top: 1.25ex',
             ast => {"property" => "margin-top",
                     "expr" => ["length" => 1.25]}
    },
    decl => {input => 'margin: 1.2ex 1.5em 125% 23px',
             ast => {property_list => [{"property" => "margin-top", "expr" => "length" => 1.2},
                                       {"property" => "margin-right", "expr" => "length" => 1.5},
                                       {"property" => "margin-bottom", "expr" => "percentage" => 125},
                                       {"property" => "margin-left", "expr" => "length" => 23}],
             }
    },
    decl => {input => 'margin: 1.2ex 1.5em',
             ast => {"property_list" => [{"property" => "margin-top", "expr" => "length" => 1.2},
                                         {"property" => "margin-right", "expr" => "length" => 1.5},
                                         {"property" => "margin-bottom", "expr" => "length" => 1.2},
                                         {"property" => "margin-left", "expr" => "length" => 1.5}]}
    },
     decl => {input => 'text-decoration: underline',
             ast => {"property" => "text-decoration",
                     "expr" => ["ident" => "underline"]}
    },
    decl => {input => 'padding-bottom: 2em',
             ast => {"property" => "padding-bottom",
                     "expr" => ["length" => 2]}
    },
    decl => {input => 'border-top-width: thick',
             ast => {"property" => "border-top-width",
                     "expr" => ["ident" => "thick"]}
    },
    decl => {input => 'border-width: 2ex 1.5em 3ex 2em',
             ast => {"property_list" => [{"property" => "border-width-top", "expr" => "length" => 2},
                                         {"property" => "border-width-right", "expr" => "length" => 1.5},
                                         {"property" => "border-width-bottom", "expr" => "length" => 3},
                                         {"property" => "border-width-left", "expr" => "length" => 2}]},
    },
    decl => {input => 'border-color: #a7f #aa77ff rgb(100,150,20) aqua',
             ast => {"property_list" => [{"property" => "border-color-top", "expr" => "color" => {"r" => 170, "g" => 119, "b" => 255}},
                                         {"property" => "border-color-right", "expr" => "color" => {"r" => 170, "g" => 119, "b" => 255}},
                                         {"property" => "border-color-bottom", "expr" => "color" => {"r" => 100, "g" => 150, "b" => 20}},
                                         {"property" => "border-color-left", "expr" => "color" => {"r" => 0, "g" => 255, "b" => 255}}]},
    },
    decl => {input => 'border-style: groove',
             ast => {"property" => "border-style",
                     "expr" => ["ident" => "groove"]},
    },
    ) {

    my $rule = $_.key;
    my %test = $_.value;
    my $input = %test<input>;

    $css_actions.reset;
     my $p = CSS::Language::CSS1.parse( $input, :rule($rule), :actions($css_actions));
    t::AST::parse_tests($input, $p, :rule($rule), :suite('css1'),
                         :warnings($css_actions.warnings),
                         :expected(%test) );
}

done;
