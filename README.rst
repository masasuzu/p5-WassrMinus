============================
WassrMinus
============================

What's this
----------------------------

WassrMinus is poor Wassr client.
It includes core module, simple script and command line tool to access Wassr.

What's Wassr
----------------------------

Micro blog service like Twitter. 

http://wassr.com/

How to use
----------------------------

First of all, you have to configure config file(/etc/config.yml)

::

  ---
  default:
    user:     USER      # input your Wassr id
    password: PASSWORD  # input your Wassr Password
    encode:   utf8      # modify if you use another encoding
  win:
    encode:   sjis 

Second, you have to set environment variable $WASSR_MINUS and add $WASSR_MINUS/lib to $PERL5LIB.

Core Module
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Core Module is implelmented as Perl module.

::

  use Net::WassrMinus;
  my $wassr = Net::WassrMinus->new{
      user     => $USER_ID,
      password => $PASSWORD,
  };
  # or $wassr = Net::WassrMinus->new_with_config($file_name, $environment);

  $wassr->update($comment, $rid, $image);
  
  # below methods returns json object
  $wassr->user_timeline($user_id);
  $wassr->friends_timeline($user_id, $page);
  $wassr->public_timeline();
  $wassr->replies();
  $wassr->show($user_id);

Script
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

You may use .bat file if you use windows.

* scripts might change specification for the future.

Commandline tool
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

For launch commandline tool, you have to input config file or user account.

::

  perl wassrm.pl [-f CONFIG_FILE [-e ENVIRONMET]] [-u USER_ID -p PASSWORD]

You can use these commands in the commandline tool.

::

  update,up      post comment
  friends,f      display friends timeline
  public,p       display public timeline
  user           display user timeline
  show,s         desplay latest comment
  replies,r      desplay reply comments

TODO
----------------------------

* Write Makefile to install as perl module
* Write unit test
* Inplement other Wassr APIs

Author
----------------------------

masasuzu / SUZUKI Masashi
m15.suzuki.masashi [at] gmail.com

See Also
----------------------------

* Wassr
 * http://wassr.com/
* Wassr API Document
 * http://wassr.com/help/api/
