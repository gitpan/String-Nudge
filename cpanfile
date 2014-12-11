requires 'perl', '5.010000';

requires 'Sub::Exporter::Progressive';

on 'test' => sub {
	requires 'Syntax::Feature::Simple::V2';
	requires 'Syntax::Feature::Qi';
    requires 'Test::NoTabs';
};
