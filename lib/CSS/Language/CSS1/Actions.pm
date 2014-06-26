use v6;

use CSS::Language::_Base::Actions;
# BUILD.pl targets
use CSS::Language::CSS1::Spec::Interface;
use CSS::Language::CSS1::Spec::Actions;

class CSS::Language::CSS1::Actions
    is CSS::Language::_Base::Actions
    is CSS::Language::CSS1::Spec::Actions
    does CSS::Language::CSS1::Spec::Interface {

        method border-width($/) { make $.list($/) }
        method border-color($/) { make $.list($/) }
        method padding-width($/) { make $.list($/) }
        method family-name($/) { make $<family-name>.ast }
        method generic-family($/) { make $<generic-family>.ast }
        method absolute-size($/) { make $.token($<keyw>.ast) }
        method relative-size($/) { make $.token($<keyw>.ast) }
}

