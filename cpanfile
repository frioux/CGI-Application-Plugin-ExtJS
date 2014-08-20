requires 'UNIVERSAL' => 0;
requires 'FindBin' => 0;
requires 'parent' => 0;
requires 'DBIx::Class' => 0.08113;
requires 'CGI::Application' => 0;
requires 'CGI::Application::Plugin::DBH' => 0;
requires 'CGI::Application::Plugin::DBIx::Class' => 0;
requires 'Readonly' => 0;

on test => sub {
   requires 'Test::More' => 0;
   requires 'Test::Deep' => 0;
};
