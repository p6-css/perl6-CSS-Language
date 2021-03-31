use v6;
use Test;
use CSS::Module::CSS3;

subset MyAlignment of Str where 'left'|'middle'|'right';
sub coerce(MyAlignment:D $keyw --> Pair) { :$keyw }

my %extensions =  %(
    '-my-align' => %(:like<text-align>),
    '-my-align2' => %(:synopsis("left | middle | right"),
                     :default<middle>,
                     :&coerce
                    ),
);

my $module = CSS::Module::CSS3.module: :%extensions;

is $module.index.tail(3)[0].name, 'z-index', 'index';
like $module.index.tail.name, /'-my-align'/, 'index';

is $module.name, 'CSS3', 'module.name';
isa-ok $module.grammar, ::('CSS::Module::CSS3'), 'css3 grammar';
isa-ok $module.actions, ::('CSS::Module::CSS3::Actions'), 'css3 actions';
my $meta = $module.property-metadata;
is-deeply $meta<-my-align>, {:inherit, :synopsis("<align> | justify")}, 'extension property';
is-deeply $meta<-my-align2>, {:default["middle", [:keyw<middle>,]], :!inherit, :synopsis("left | middle | right")}, 'extension property';

my $module2 = CSS::Module::CSS3.module;
my $meta2 = $module2.property-metadata;
nok $meta2<-my-align>:exists, 'extensions are isolated';

done-testing;
