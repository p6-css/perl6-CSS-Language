#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS21;
use CSS::Language::CSS21::Actions;
use lib '.';
use t::AST;

my $css_actions = CSS::Language::CSS21::Actions.new;

for (
    decl => {input => 'azimuth: 30deg',       ast => {property => 'azimuth', expr=> [angle => 30]},
    },
    decl => {input => 'Azimuth : far-right',  ast => {property => 'azimuth', expr  => [angle => 60]},
    },
    decl => {input => 'azimuth: center-left behind',  ast => {property => 'azimuth', expr => [angle => 200]},
    },
    decl => {input => 'AZIMUTH : Rightwards',  ast => {property => 'azimuth', expr => [delta => 20]},
    },
    decl => {input => 'azimuth: inherit',     ast => {property => 'azimuth', inherit => True},
    },
    decl => {input => 'elevation: 65DEG',     ast => {property => 'elevation', expr => [angle => 65]},
    },
    decl => {input => 'elevation:above',      ast => {property => 'elevation', expr => [angle => 90]},
    },
    decl => {input => 'elevation : LOWER',    ast => {property => 'elevation', expr => [delta => -10]},
    },
    decl => {input => 'background-attachment: FiXed',   ast => {property => 'background-attachment', expr => [ident => 'fixed']},
    },
    decl => {input => 'Background-Attachment :inherit', ast => {property => 'background-attachment', inherit => True},
    },
    decl => {input => 'background-color : #37a', ast => {property => 'background-color', expr => [color => {r => 0x33, g => 0x77, b => 0xAA}]},
    },
    decl => {input => 'background-image : url(images/ok.png)', ast => {property => 'background-image', expr => [url => 'images/ok.png']},
    },
    decl => {input => 'background-repeat : Repeat-x', ast => {property => 'background-repeat', expr => [ident => 'repeat-x']},
    },
    decl => {input => 'background-position : 100% 90%', ast => {"property" => "background-position", "expr" => [["percentage" => 100, "percentage" => 90]]},
    },
    ) {

    my $rule = $_.key;
    my %test = $_.value;
    my $input = %test<input>;

    $css_actions.reset;
     my $p = CSS::Language::CSS21.parse( $input, :rule($rule), :actions($css_actions));
    t::AST::parse_tests($input, $p, :rule($rule), :suite('css21'),
                         :warnings($css_actions.warnings),
                         :expected(%test) );
}

done;