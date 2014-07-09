use v6;

# CSS3 Namespaces Extension Module
# specification: http://www.w3.org/TR/2011/REC-css3-namespace-20110929/
#
class CSS::Module::CSS3::Namespaces::Actions {...}

use CSS::Module::CSS3::_Base;

grammar CSS::Module::CSS3::Namespaces:ver<20110929.000>
    is CSS::Module::CSS3::_Base {

    rule at-decl:sym<namespace> {(:i'namespace') <prefix=.ident>? [<url=.string>|<url>] ';' }

}

class CSS::Module::CSS3::Namespaces::Actions
    is CSS::Module::CSS3::_Base::Actions {
    method at-decl:sym<namespace>($/) { make $.at-rule($/) }
}
