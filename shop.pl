#!/usr/bin/perl
use strict;
local our $pay_pal='No';
local our $bn='OnlineStore_Cart_WPS';
local our $paypal_shipping = 'No';
local our $paypal_no_note = '';
local our $paypal_cn = '';
local our $paypal_no_shipping = '2';
local our $paypal_cancel_payment = '';
local our $paypal_return = '';
local our $paypal_image_url = '';
local our $paypal_express = 'No';
local our $paypal_pro = 'No';
local our $paypal_pro_uk = 'No';
local our $paypal_url = 'www.paypal.com';
local our $google_checkout = 'No';
local our $google_server = 'Live';
local our $google_id = '';
local our $sb_google_id = '';
local our $temp_dir = '';
local our $payoffline = 'No';
local our $offline_mid = '';
local our $offline_returnurl = '';
local our $offline_md5 = '';
local our $doc_dir = '';
local our $business='';
local our $currency_code='GBP';
local our $lc='GB';
local our $currency_symbol='&#163;';
local our $trans='ssc1';
local our $worldpay='No';
local our $instId='';
local our $acc_Id='';
local our $testMode='100';
local our $auth='A';
local our $postbox = '';
local our $tax_rates = ',,,,,,,,,,,,,,,,,,,,,,,,';
local our $vat_on_post = 'No';
local our $sales_tax_label = '';
local our $nochex = 'No';
local our $nochex_email = '/usr/lib/sendmail';
local our $nochex_logo = '';
local our $nochex_return = '';
local our $nochex_cancel = '';
local our $barclay = 'No';
local our $authorizenet = 'No';
local our $authorizenet_aim = 'No';
local our $authorizenet_mode = 'Not Used';
local our $authorizenet_login_id = '';
local our $authorizenet_transaction_id = '';
local our $authorizenet_testmode = 'TRUE';
local our $authorizenet_x_type = 'AUTH_CAPTURE';
local our $authorizenet_aim_check = 'No';
local our $authorizenet_fargo_cc= 'No';
local our $authorizenet_fargo_check = 'No';
local our $authorizenet_url = 'https://secure.authorize.net/gateway/transact.dll';
local our $weight_text = 'Weight kg';
local our $telephone_order_form = 'No';
local our $script_address = '';
local our $mail_order_form = 'No';
local our $store_name = '';
local our $store_logo = '';
local our $java_discount ='';
local our $minimum_order ='';
local our $net = '';

local our $k = '<br><br><br><a href="http://www.online-store.co.uk/about.html" onClick="alert(\'Purchase the registered version of the shopping cart to remove this link. www.online-store.co.uk.\');return false;">This is a demonstration Shopping Cart.<br>Click for Details.</a></b>';

# Copyright Online-Store.co.uk 2012

# User Defined

my $terms_and_conditions = 'No';
my $terms_and_conditions_url = '';
my $continue_shopping_url = '';


my $drop_down_3='';
my $drop_down_3_title='';

my $google_checkout = '';
my $google_id = '';
my $google_key = '';
my $google_server = '';

$paypal_shipping="Yes";

local our %portraits;

local our $active_frame='0';

local our $find_error ='';

local our $server="shop.pl";   

my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst)=localtime(time);

# time plus process id $$ to give unique_id

#local our $unique_id = "$year:$mon:$mday:$hour:$min:$sec-$$";
local our $unique_id = time;

if($ENV{'SCRIPT_NAME'} ne undef)
   {
   $server = $ENV{'SCRIPT_NAME'};	
   if($ENV{'SCRIPT_NAME'} =~ /shop.pl/i)
      {
	  $server = "shop.pl"; 
      }
   
   }
   
########### Code Segment #######################
if($doc_dir eq "")

   {


 # if ($ENV{'DOCUMENT_ROOT'} ne undef)
 #     {
 #     $doc_dir = $ENV{'DOCUMENT_ROOT'};
 #     $doc_dir = $doc_dir . '/';
 #     }
 #  else
 #     {
	  #if($ENV{'PATH_TRANSLATED'} ne undef)
	 
      if($ENV{'SCRIPT_FILENAME'} ne undef)
         {
         my $doc1 = $ENV{'SCRIPT_FILENAME'};
         $doc1 =~ s#\\#/#g;
         my $pos1 = rindex($doc1,'/');
         
         $doc_dir = substr($doc1,0,$pos1);
         
        # $doc1 = substr($doc1,0,$pos1);
        # $pos1 = rindex($doc1,'/');
        # $doc_dir = substr($doc1,0,$pos1);

         $doc_dir = $doc_dir . '/';
         }
  #    }
   }   
  
if($currency_code eq "EUR")
   {
   $currency_symbol = "&euro;";
   }      
  
   
       
local our ($weight_name,$weight_symbol) = split (/ /, $weight_text);

# user defined local directory      
      
#$doc_dir = "";   
   

local our $tax_label = "";

local our $cost_of_stamps = "0";
local our $dtax="0";

local our $vat=0;

local our $final_bill = 0;

local our $cur_postage = "";
local our $total_weight = 0;

local our $product_des = "";
local our $short_product_des = "";

local our $tax_total;

local our %TAX;
local our %POST;


###### Check referrer #####

#@referers = ('www.your-domain.com','www.your-domain.co.uk');

#if ($ENV{'HTTP_REFERER'})
#   {
#   foreach $referer (@referers)
#      {
#      if ($ENV{'HTTP_REFERER'} =~ /$referer/i)
#         {
#         $check_referer = '1';
#	     last;
#         }
#      }
    
#   if ($check_referer != 1)
#      {
#      &end_cgi("referrer not allowed");;
#      }   
#   }
  

###  legacy code ###

#$price{'a'} = 105;



    # Fetch the data for this request.
my $data = "";

    if ( $ENV{'REQUEST_METHOD'} eq 'POST' )
       {
       # Read it from standard input.
       my ($len) = $ENV{'CONTENT_LENGTH'};
       if ( read (STDIN, $data, $len) != $len )
         {
         &end_cgi("Error reading 'POST' data");
         }
       }
    else
       {
       # Fetch from environment variable.
       $data = $ENV{'QUERY_STRING'};
       }

local our %q = ();           # resultant hash array

    # The data is encoded as name1=val1&name2=val2&etc.
    # First split on name/value pairs.
    foreach my $q ( split ('&', $data) ) {
        # Then split name and value.
        my ($name, $val) = split ('=', $q);

        # URL decode and put in resultant hash array.
        
        $name = &url_decode ($name);
        $val  = &url_decode ($val);
        
        $name=&convert2($name);
        $val=&convert2($val);
               
#        if ( defined $q{$name} ) {
           # Multiple values. Append using \0 separator.
#            $q{$name} .= "\0" . $val;
#        }
#        else {
            # Store it.
            $q{$name} = $val;
#        }
      }

      
#### Decode Cart Overwrite variable ####


#my $encrypt ='No';

#if($encrypt eq 'Yes')
#{

##print"Content-Type: text/html\n\n";



##print "testing$q{'cart'}<br><br>";


if($q{'cart'} ne '' && $q{'B2'} ne '')
   {
##   print "view order<br>";	   
  #### $q{'username'} = split('\|',&decode_base63($q{'cart'}));	   
	   
   }


if($q{'cart'} ne '' && $q{'B2'} eq '')
   {
##   print "add to cart<br>";

 ####  ($q{'username'},$q{'add_to_order'},$q{'id'},$q{'item_price'},$q{'weight'},$q{'choices_1'},$q{'choices_2'},$q{'choices_3'})
      
 ####  = split('\|',&decode_base63($q{'cart'}));
   
    
##   print $q{'add_to_order'};
   
##   print $q{'username'};
   
  
   for(my $m=1;$m<4;$m++)
      {
      if($q{"menu_$m"} ne '')
         { 
##       print "<br>Process menu_$m $q{'menu_' . $m}<br><br>";    
   	       
         my ($title,@choices)  = split (/,/,$q{"choices_$m"});
	
         $q{"m$m"} = "$title";
         
         # test for menu not selected
         
         if($q{"menu_$m"} eq '0')
            {
	        $q{"menu_$m"} = "Select $title";
	        last; 
            }
                        
         my $n=1;
         
         # Menu = Select causes error
         # Replace Select with 0 ?
         # if select > 0 then use cart data
      
         foreach my $choice (@choices)
            {
##     	    print "<br>Process choice $choice-$m-$n-" . $q{"menu_$m"} . "-<br><br>";   
    
            if($n eq $q{"menu_$m"})
   	           {
	   	       #print "<br>menu_1 = $choice<br><br>";     	  
	           $q{"menu_$m"} = $choice;
	           last;
               }
            $n++;
            }
    
         }

      }   
   
   }

#}   
   
#### End of Cart overwrite ##############      
       
local our %cookie_hash;

      
if ($ENV{'HTTP_COOKIE'} ne undef)
    {  
	my @cookies = split (/; /, $ENV{'HTTP_COOKIE'});
	foreach my $cookie (@cookies)
	  {
   	  	  
	  my ($name, $value) = split (/=/, $cookie);
	  $name = &uri_unescape($name);	
	 # $value = &uri_unescape($value);	
	  
	  $cookie_hash{$name} = $value;
	  } 
    }
 
if($q{'store_referer'} eq undef)
   {
   if($ENV{'HTTP_REFERER'} =~ /.htm/i)
      { 
      $q{'store_referer'} = $ENV{'HTTP_REFERER'};	
      }  
   }

if($q{'store_history'} eq undef)
   {
   $q{'store_history'} = 1;	
	
   }
else
   {
   $q{'store_history'} = $q{'store_history'} + 1;	
   }
  
if($cookie_hash{'terms'} eq 'Yes')
   {
   $q{'agree_terms'} = 'Yes'
   }   
    

####### read setup data if present #############

### check authorize sim links ###

my $override = "No";

my $chargetype="";
my $clientid="";
my $password="";



local our $secure_server = '';

if($ENV{'SCRIPT_NAME'} ne undef)
   {


   if($ENV{'HTTP_HOST'} =~ /localhost/i)
      {       
      $secure_server = "http://" . $ENV{'SERVER_NAME'} . $ENV{'SCRIPT_NAME'};
      }
   else
      {
	  if(($ENV{'HTTP_HOST'} =~ /online-store/i) && ($override eq 'Yes'))
         {
         $secure_server = "https://" . $ENV{'SERVER_NAME'} . '/shop3/' . $q{'username'} . '/';
         $doc_dir = $ENV{'DOCUMENT_ROOT'} . '/shop3/' . $q{'username'} . '/';
         }
      else
         {     
         $secure_server = "https://" . $ENV{'SERVER_NAME'} . $ENV{'SCRIPT_NAME'};	
         }
      }	   
	   
   my $doc1 = $secure_server;
   $doc1 =~ s#\\#/#g;
   my $pos1 = rindex($doc1,'/');
         
   $secure_server = substr($doc1,0,$pos1);
       
   # $doc1 = substr($doc1,0,$pos1);
   # $pos1 = rindex($doc1,'/');
   # $doc_dir = substr($doc1,0,$pos1);

   $secure_server = $secure_server . '/';
   }


 
if($override eq "Yes")
   {
  # check if online store
	
	
my $data_file_contents ="";


my $file= $doc_dir . "data_file.ssc";

   #( open (FILE_LIST,$file) ) || (&end_cgi ("$doc_dir:Cannot read $file: $!"));
   
   (open (FILE_LIST,$file) ) || (&end_cgi ("$file--$q{'username'} has not been found: $!"));
   
   while (<FILE_LIST>)
      {
      $data_file_contents = $data_file_contents . $_;

      }
 
    close(FILE_LIST);

   my %r=();

    
######## Decode Data File ##############


    # The data is encoded as name1=val1&name2=val2&etc.
    # First split on name/value pairs.
    foreach my $r ( split ('\|', $data_file_contents) ) {
        # Then split name and value.
        my ($name, $val) = split ('=', $r);
       # URL decode and put in resultant hash array.
        $name = &url_decode ($name);
        
        #$r{$name} = &url_decode ($val); 
        $r{$name} = $val; 
    }  



#### process cookies ####


if($q{'username'} eq 'TestOnlineStore' || $q{'username'} eq 'shop3test')
   {

   my $z=0;

   while($cookie_hash{"temp$z"} ne undef) 
      {
      my @q_data = split("!#", $cookie_hash{"temp$z"});
   
      foreach my $cookie (@q_data)
         {
         my ($name, $val) = split ('\|',$cookie);

         $name = &uri_unescape($name);
      
         $val = &uri_unescape($val);
      
         # override data file values;
      
         $r{$name} = $val;

         }
      $z++;       
      } 
      
   }  
   
   

     
########################    
    
   
    
#<input type='hidden' name='lc' value=''>
#<input type='hidden' name='currency_code' value=''>

$store_name=$r{'store_name'};$store_logo=$r{'store_logo'};
    
$worldpay=$r{'worldpay'};$instId=$r{'instId'};$acc_Id=$r{'accId1'};$auth=$r{'authMode'};$testMode=$r{'testMode'};

$barclay=$r{'barclay'};

$google_checkout=$r{'google_checkout'};$google_id=$r{'google_id'};$google_key=$r{'google_key'};$google_server=$r{'google_server'};

$authorizenet=$r{'authorizenet'};$authorizenet_login_id=$r{'authorizenet_login_id'};$authorizenet_transaction_id=$r{'authorizenet_transaction_id'};$authorizenet_testmode=$r{'authorizenet_testmode'};$authorizenet_url=$r{'authorizenet_url'};

$authorizenet_aim=$r{'authorizenet_aim'};$authorizenet_aim_check=$r{'authorizenet_aim_check'};$authorizenet_fargo_cc=$r{'authorizenet_fargo_cc'};$authorizenet_fargo_check=$r{'authorizenet_fargo_check'};

$pay_pal=$r{'paypal'};$business=$r{'business_name'};$paypal_no_shipping=$r{'paypal_no_shipping'};$paypal_no_note=$r{'paypal_no_note'};$paypal_cn=$r{'paypal_cn'};
   
$paypal_url=$r{'paypal_url'};$paypal_image_url=$r{'paypal_image_url'};$paypal_cancel_payment=$r{'paypal_cancel_payment'};$paypal_return=$r{'paypal_return'};
   
$nochex=$r{'nochex'};$nochex_email=$r{'nochex_email'};$nochex_logo=$r{'nochex_logo'};$nochex_return=$r{'nochex_return'};$nochex_cancel=$r{'nochex_cancel'};  

$tax_rates=$r{'sales_tax'};$postbox=$r{'shipping'};$currency_code=$r{'currency_code'};$weight_text=$r{'weight_text'};
   
$paypal_pro=$r{'paypal_pro'};$paypal_express=$r{'paypal_express'};$paypal_pro_uk=$r{'paypal_pro_uk'};
   
##$APIusername=$r{'APIusername'};$APIpassword=$r{'APIpassword'};$APIsignature=$r{'APIsignature'};$PayPalAccount=$r{'PayPalAccount'};$SBAPIusername=$r{'SBAPIusername'};$SBAPIpassword=$r{'SBAPIpassword'};$SBAPIsignature=$r{'SBAPIsignature'};
 
#$PAYMENTACTION=$r{'PAYMENTACTION'};$CancelURL=$r{'CancelURL'};$ReturnURL=$r{'ReturnURL'};$HTTPS_PROXY=$r{'HTTPS_PROXY'};
   
#$UKvendor=$r{'UKvendor'};$UKusername=$r{'UKusername'};$UKpassword=$r{'UKpassword'};$UKtest=$r{'UKtest'};
   
#$protx=$r{'protx'};$vendor=$r{'vendor'};$protx_password=$r{'protx_password'};$txtype=$r{'txtype'};$protx_merchant_email=$r{'protx_merchant_email'};$protx_server=$r{'protx_server'};
 
#$sendmail=$r{'sendmail'};$merchant_email=$r{'merchant_email'};$script_address=$r{'script_address'};$p1=$r{'p1'};$u1=$r{'u1'};

($weight_name,$weight_symbol) = split (/ /, $weight_text);

$terms_and_conditions = $r{'terms_and_conditions'};

$terms_and_conditions_url = $r{'terms_and_conditions_url'};

$continue_shopping_url = $r{'continue_shopping_url'};


$drop_down_3 = $r{'drop_down_3'};

$drop_down_3_title = $r{'drop_down_3_title'};

$vat_on_post = $r{'vat_on_post'};
    
$lc='';
$currency_symbol='';

if($currency_code eq '')
   {
   $currency_code = 'USD';	   
   }

if($currency_code eq 'USD')
   {
   $lc='US';
   $currency_symbol='$';
   }   
   
if($currency_code eq "GBP")
   {
   $lc='GB';
   $currency_symbol='&#163;';
   }

if($currency_code eq "JPY")
   {
   $lc='JP';
   $currency_symbol='&yen;';
   }

if($currency_code eq "EUR")
   {
   $lc='GB';
   $currency_symbol='&euro;';
   }

if($currency_code eq "CAD")
   {
   $lc='CA';
   $currency_symbol='$';
   }

if($currency_code eq "AUD")
   {
   $lc='AU';
   $currency_symbol='$';
   }

if($paypal_pro =~ /Pro/i)
   {
   $paypal_express = 'No';
   $paypal_pro = 'Yes';
   $paypal_pro_uk = 'No';
   }
   
#if($paypal_pro =~ /UK/i)
#   {
#   $paypal_express = 'No';
#   $paypal_pro = 'No';
#   $paypal_pro_uk = 'Yes';
#   }
   
if($paypal_pro =~ /Express Only/i)
   {
   $paypal_express = 'Yes';
   $paypal_pro = 'No';
   $paypal_pro_uk = 'No';
   }
   
} 
  
##### Setup Sales Tax Label ######

if($sales_tax_label eq "")
   {
   if($currency_code eq 'GBP' || $currency_code eq 'EUR')
      {
      $sales_tax_label = 'VAT';
      }	
   else
      {
      $sales_tax_label = 'Sales Tax'		
      }
   }	

##### process Authorize Net Orders    
    
if ($q{'x_Version'} ne undef)
{

print"Content-Type: text/html\n\n";


#$remote_addr = &addr_to_host($ENV{"REMOTE_ADDR"});   
   

print '<HTML>
<HEAD>
<TITLE>Shopping Cart</TITLE>
</HEAD>
<BODY onLoad = "document.postform.submit();">
<p align="center"><font color="#0000FF"><strong><big><big><big>
Connecting to the Server: Please wait
</big></big></big></strong></font><br><br>
';


print "<FORM name='postform' action=" . "'$authorizenet_url'" . " method='post'>";                                         
print "<input type=\"hidden\" name=\"x_Login\" value=\"$authorizenet_login_id\">\n";
print "<input type=\"hidden\" name=\"x_show_Form\" value=\"PAYMENT_FORM\">\n";
print "<input type=\"hidden\" name=\"x_Test_Request\" value=\"$authorizenet_testmode\">\n";   

#### Authorize Users should uncomment these lines ####

use lib ('$doc_dir');

#use SimLib;

#&SimLib::InsertFP($authorizenet_login_id,$authorizenet_transaction_id,$q{'x_Amount'});

    
while (my ($name,$description) = each(%q))

{
	
my $temp_value = &convert($description);
	
	
if("\L$name" ne "submit" && "\L$name" ne "x_login" && "\L$name" ne "store_referer" && "\L$name" ne "store_history")
   {
   print "<input type=\"hidden\" name=\"$name\" value=\"$temp_value\">\n";
   }
}

print  '<INPUT type="submit" name="submit_button" value="Click if not automatically connected"><br><br>';
print '</p></FORM>';
print '</BODY></HTML>';

exit;

}


#my $html = "Content-Type: text/html; charset=UTF-8\n\n";
#my $html = "Content-Type: text/html; charset=ISO-8859-1\n\n";
my $html = "Content-Type: text/html; charset=ISO-8859-1\n\n";   
   
##### Calc Shipping #######
#shipping


#$sales_tax = $q{'sales_tax'};

#$tax="";

my $prefix="";
my $n=0;
my $no_of_posts=0;

foreach my $rate (split ("\n", $postbox))
   {
       $rate =~ s/\n//;
      $rate =~ s/\r//;
	   
   if($rate ne "")
      {	   
      if(index($rate,'$') == -1 && index($rate,'�') == -1 && index($rate,'%') == -1)
         {      	
	     $prefix = $rate;
	     $no_of_posts++;	
         }
      else
         {
         
         $POST{$n} = $prefix . "," . $rate;
         #$tax = $tax . $n . $POST{$n} . "<br>";
         $n++;
         }

      }
   }

  
   
 #sales_tax


$n=0;
foreach my $rate (split (",", $tax_rates))
   {
   if ($n%2==1)
      {
      $rate =~ s/\%//g;
      $TAX{$n-1} =~ s/$rate\%//;
      }
      
      $TAX{$n} = $rate;
 #      $html = $html . ($TAX{$n} . "\n");
         $n++;  
    }
   
my $single_rate = $n;

if($n==2)
   {
   $q{'sales_tax'} = $TAX{'0'};

   }

if($no_of_posts == 1)
   {
   $q{'shipping'} = $prefix;
   }
    
       

# subsitute code letters for price codes.

#$q{'item_price'}= "\L$q{'item_price'}";

#if($price{$q{'item_price'}} ne undef)
#   {
#   $q{'item_price'} = $price{$q{'item_price'}};
#   }    
    

       
##$addr1 = $q{"mail"};
##$process_name = $q{"process_id"};
##$process_name =~ s#\.\.([/\:]�$)##g;


# Process E-Mail Request


   $tax_label = $q{'sales_tax'};
   
   $cur_postage = $q{'shipping'};
  
   if($q{'m1'} eq undef){$q{'m1'}="";}
   if($q{'m2'} eq undef){$q{'m2'}="";}
   if($q{'m3'} eq undef){$q{'m3'}="";}
   
   if($q{'menu_1'} eq undef){$q{'menu_1'}="";}
   if($q{'menu_2'} eq undef){$q{'menu_2'}="";}
   if($q{'menu_3'} eq undef){$q{'menu_3'}="";}
   
   if($q{'weight'} eq undef)
   {$q{'weight'}="";}
   else
   {$q{'weight'} =~ s/[^\d.]//g;}
 
   #$html = $html ."Content-Type: text/html\n\n";
 
   #local ($i) = @_;


local our %form_data;

my $begin ="<HTML>
<HEAD>
<TITLE>Shopping Cart</TITLE>
</HEAD>
<BODY topmargin='5' leftmargin='10' onload='javascript:this.focus();'>";

my $end =
"<!--version 3.96c 04 Jan 2009--></BODY>
</HTML>";
  

my $z=0;

#if($cookie_hash{'Cust'} ne undef)

while($cookie_hash{"Cust$z"} ne undef) 
 
   {

   #$out="";
   #$weight="0";
   #$id="";
   #$add="";
   #$price="";
   #$q="";

   foreach (split ("!#", $cookie_hash{"Cust$z"}))

      {
      #$out = $out . $_;

      $_ = &uri_unescape($_);
      
      $_ =~ s/\n//;
      $_ =~ s/\r//;

      my($q,$id,$add,$price,$weight,$m1,$menu_1,$m2,$menu_2,$m3,$menu_3)= split('\|',$_);
      
      #$id = &uri_unescape($id);
      #$add = &uri_unescape($add);
      #$price = &uri_unescape($price);
      #$wright = &uri_unescape($weight);
      #$m1 = &uri_unescape($m1);
      #$menu_1 = &uri_unescape($menu_1);
      #$m2 = &uri_unescape($menu_2) ;
      #$menu_2 = &uri_unescape($menu_2);
      #$m3 = &uri_unescape($menu_3) ;
      #$menu_3 = &uri_unescape($menu_3);

      my $old_record = $id .'|' .$add .'|' . $price .'|' . $weight .'|' .$m1 .'|' . $menu_1 .'|' .$m2 .'|' . $menu_2 .'|' .$m3 .'|' . $menu_3;

      
   # Remove any deleted records
               
      if($q{&unconvert($old_record)} ne "ON")
         {
	     if($q{$old_record} ne "ON")
            {          
            $form_data{$old_record} = $q;

            if($weight ne "" && $weight > 0)
               {
               $total_weight = $total_weight + ($weight * $q);
               }     
        
            }    
         }   

      }
   $z++;       
   } 
  
   
   
   
   
my $base_price=$q{'item_price'};   
   
my $org_item_price =  $q{'item_price'};   



if($q{'B1'} ne undef)
   {
	   
my $back_button ="<script language='JavaScript'><!--\r\n" .
   "document.write('<br><br><input type=\"button\" value=\"Return\" name=\"b1\" onClick=\"history.go(-1)\">&nbsp;&nbsp;')" .           
   "\r\n--></script>";	   
	   
                
if($q{'menu_1'} ne undef && index($q{'menu_1'},'Select') != -1)
   {
	   
print "Content-Type: text/html\n\n";   	   
   print $begin;
   print "<br><br>Error. $q{'menu_1'}";
   print $back_button;
   print $end;
   exit;    
   }

if($q{'menu_2'} ne undef && index($q{'menu_2'},'Select') != -1)
   {
print "Content-Type: text/html\n\n";
   print $begin;   	   
   print "<br><br>Error. $q{'menu_2'}";
   print $back_button;
   print $end;
   exit;    
   }
     
if($q{'menu_3'} ne undef && index($q{'menu_3'},'Select') != -1)
   {
print "Content-Type: text/html\n\n"; 
   print $begin;  	   
   print "<br><br>Error. $q{'menu_3'}";
   print $back_button;
   print $end;
   exit;    
   }
}


#if ($q{'B1'} ne undef && $q{'B1'} ne "View Order")
# Not View Store
#if ($q{'B2'} eq undef && $q{'view_order'} eq '' && $q{'b6'} eq undef && $q{'b7'} eq undef)


######## patch one ####

if($q{'username'} eq 'blackandwhitegalleries')
   {
   &unattached_pics();
   }

######## end of patch ####


if($q{'B1'} ne undef || ($cookie_hash{'Cust0'} eq undef && ($q{'b6'} ne undef || $q{'b7'} ne undef)))
   {
   if ($q{'add_to_order'} ne undef)
      {
       $q{'add_to_order'} = &convert($q{'add_to_order'});   
	   
   
       
   if($q{'menu_1'} ne undef || $q{'menu_1'} eq "")
      {
      #$q{'add_to_order'} = $q{'add_to_order'} . ":" . $q{'m1'} . ":" . $q{'menu_1'};
	   
      my $temp = &scan($q{'menu_1'});
	   
      if($temp ne "")
         {
         $q{'item_price'} = $q{'item_price'} + $temp;
	     }
	  #$html = $html . $temp;
	  #$price = $price + $q{'item_price'};
	            
      }

             
   if($q{'menu_2'} || $q{'menu_2'} eq "")
       {
	   #$q{'add_to_order'} = $q{'add_to_order'} . ":" .  $q{'m2'} . $q{'menu_2'};
	   
	   my $temp = &scan($q{'menu_2'});
	   
	   if($temp ne "")
	      {
		  $q{'item_price'} = $q{'item_price'} + $temp;
	      }
	   	           
       }

   if($q{'menu_3'} ne undef || $q{'menu_3'} eq "")
       {
	   #$q{'add_to_order'} = $q{'add_to_order'} . ":" . $q{'m3'} . $q{'menu_3'};
	   
	   my $temp = &scan($q{'menu_3'});
	   
	   if($temp ne "")
	      {
		  $q{'item_price'} = $q{'item_price'} + $temp;
	      }
	   	          
       }
       
   
   if($org_item_price ne  $q{'item_price'})
      {
	      
	  if($org_item_price ne '' && $org_item_price != '0')
	     {    
	     $q{'add_to_order'} .= " - $currency_symbol$org_item_price";
         }   
      }
    
   
      
#### patch two #####
   
#### Assign unique number to frame
 
if($q{'username'} eq 'blackandwhitegalleries')
   {     
   &set_frame_id();   
   }   
          
       
   # Add any new menu items to new record    
       
   my $new_record = $q{'id'} .'|' . $q{'add_to_order'} .'|' . $q{'item_price'} .'|' . $q{'weight'} .'|' .  $q{'m1'} .'|' . $q{'menu_1'}  .'|' .  $q{'m2'} .'|' . $q{'menu_2'}  .'|' .  $q{'m3'} .'|' . $q{'menu_3'}  ;

   #$new_record = $new_record;

   # add on previously bought items 
   
   
   
   # Selected records eq "ON" and are marked for deletion  
   
     if($q{&unconvert($new_record)} ne "ON")
        {
        if($q{$new_record} ne "ON")   
           {
           if($form_data{$new_record} eq undef)
              {
              if($q{'weight'} ne "" && $q{'weight'} > 0)
                 {
                 $total_weight = $total_weight + ($q{'weight'} * $q{'qty'});        
                 } 
              } 
           else
              {
	          if($q{'weight'} ne "" && $q{'weight'} > 0)
                 {
                 $total_weight = $total_weight + ($q{'weight'} * ($q{'qty'}-$form_data{$new_record}));        
                 }   
	              
              } 
                 
           $form_data{$new_record} = $q{'qty'};   
           }
        }

   }


}   
   
#   $html = $html . "## $total_weight";

local our $total = 0;
my $save = "";
my $out ="";
my $id = "";

local our %pay_item;
local our %pay_code;
local our %pay_price;
local our %pay_tax;
local our %pay_qty;
local our %pay_weight;
local our %pay_m1;
local our %pay_menu_1;
local our %pay_m2;
local our %pay_menu_2;
local our %pay_m3;
local our %pay_menu_3;

########### Begin shop.pl output ###################


$product_des = "";
$short_product_des = "";
my $y=0;
my %save;
$save{'0'}='';

  # while(my ($first,$last) = each(%form_data))
  #    {
foreach  my $first (sort keys %form_data)
   {
   my $last = $form_data{$first};
	      
	      
	      
      if($last ne "DEL")
         {
	         
	     my $temp = $save{$y} . &uri_escape($last) . '|' . &uri_escape($first) . "!#"; 
	     
	     if(length($temp)<4000)
            {  
	        $save{$y} = $temp;
            }    
         else
            {
	        $y++;
	        $save{$y} = &uri_escape($last) . '|' . &uri_escape($first) . "!#"; 
	            
	            
            }         
          
         $first =~ s/\n//;
         $first =~ s/\r//;
         
         my($id,$add,$price,$weight,$m1,$menu_1,$m2,$menu_2,$m3,$menu_3) = split('\|',$first);

         #$product_add = $add;
         
         my $product_menu = "";
         
         if($m1 ne ""){$product_menu = $product_menu . $menu_1 . " ";}
         if($m2 ne ""){$product_menu = $product_menu . $menu_2 . " ";}
         if($m3 ne ""){$product_menu = $product_menu . $menu_3 . " ";}
         
         
        # $product_des = $product_des . "$id  $add $product_menu($last x $currency_symbol$price)\r\n";
         
         # patch for picture gallery users
         if($q{'username'} eq 'blackandwhitegalleries')
            {
            $short_product_des = $short_product_des . "$id $product_menu($currency_symbol$price)\r\n";
            
            $product_des = $product_des . "$id  $add $product_menu\r\n";
            }
         else
            {
            $short_product_des = $short_product_des . "$id $product_menu($last x $currency_symbol$price)\r\n";
            
            $product_des = $product_des . "$id  $add $product_menu($last x $currency_symbol$price)\r\n";
            }
         
         }
      }

   my $x=0;      
   while($save{$x} ne "")
      {   
      print "Set-Cookie: Cust$x=" . $save{$x} . ";\n";
      $x++;
      }
      
   print "Set-Cookie: Cust$x=;\n";
   
   
   
   if($q{'agree_terms'} eq 'Yes')
      {
      print "Set-Cookie: terms=Yes;\n";
      } 

#### Gallery patch Three ##########

if($q{'username'} eq 'blackandwhitegalleries')
{
&set_gallery_cookies();
}


   
   
   
#<meta http-equiv='Content-Type' content='text/html; charset=UTF-8'>


if($net ne 'ssc3' && index($k,'egis') == -1)
{
$k = '<font size="6" color="#FF0000">DE';	
$k .='MO&nbsp;C'. 'ART</font>';	
}





$html = $html . $begin;


$html = $html .'<br>
<form method="post" action="';
$html = $html . $server;

$html = $html .'">';

# no cookies process last item added to cart

#if($cookie_hash{'Cust'} eq undef)
if($cookie_hash{'Cust0'} eq undef)	   	   
   { 
   $html = $html ."<input type='hidden' value='" . $q{'add_to_order'} . "' name='add_to_order'>";
   $html = $html ."<input type='hidden' value='" . $q{'weight'} . "' name='weight'>";
   $html = $html ."<input type='hidden' value='" . $q{'id'} . "' name='id'>"; 
   $html = $html ."<input type='hidden' value='" . $q{'qty'} . "' name='qty'>"; 
   $html = $html ."<input type='hidden' value='" . $org_item_price . "' name='item_price'>"; 
   $html = $html ."<input type='hidden' value='" . $q{'m1'} . "' name='m1'>"; 
   $html = $html ."<input type='hidden' value='" . $q{'menu_1'} . "' name='menu_1'>";
   $html = $html ."<input type='hidden' value='" . $q{'m2'} . "' name='m2'>"; 
   $html = $html ."<input type='hidden' value='" . $q{'menu_2'} . "' name='menu_2'>";
   $html = $html ."<input type='hidden' value='" . $q{'m3'} . "' name='m3'>"; 
   $html = $html ."<input type='hidden' value='" . $q{'menu_3'} . "' name='menu_3'>";   
   }	   
   
   if($q{'store_referer'} ne undef)
      {
      $html = $html ."<input type='hidden' value='" . $q{'store_referer'} . "' name='store_referer'>";
      }
      
   $html = $html ."<input type='hidden' value='" . $q{'store_history'} . "' name='store_history'>";


$html = $html ."<input type='hidden' value='" . $q{'username'} . "' name='username'>";


#onClick='self.close();'


#if($q{'store_referer'} ne undef)
#   {
#   $html = $html . "<input type='button' value='Continue Shopping' name='b1' onClick='location.href=\"$q{'store_referer'}\"'>&nbsp;&nbsp;";   
#   }
#else
#   {
	

if($q{'username'} eq 'TestOnlineStore' || $q{'username'} eq 'shop3test')
   {
$store_name = 'Test Order Form ' . $store_name;
	   
}	
	
	

if($store_name ne '')
   {
   #$html .= "<table border='0'><tr><td>";

   if($store_logo ne '')
   {
   $html .= "<font face='Arial' size='6'><img src='$store_logo'></font>";
   }
#alt="WorldPay.jpg (8124 bytes)">
    
   #$html .= "</td><td>";	    
      
   $html .= "<font face='Arial' size='6'>&nbsp;&nbsp;&nbsp;$store_name</font><br><hr width='640' align='left'><br>";  
     
   #$html .= "</td></tr></table><br><br>";   
   }
	
   
   if($continue_shopping_url eq '')
      {
      $html = $html . "<script language='JavaScript'><!--\r\n" .
      "document.write('<input type=\"button\" value=\"Continue Shopping\" name=\"b1\" onClick=\"history.go(-$q{\"store_history\"})\">&nbsp;&nbsp;')" .           
      "\r\n--></script>";
      }
   else
      {
	  $html = $html . "<script language='JavaScript'><!--\r\n" .
      "document.write('<input type=\"button\" value=\"Continue Shopping\" name=\"b1\" onClick=\"window.open(\\'$continue_shopping_url\\',\\'_self\\')\">&nbsp;&nbsp;')" .           
      "\r\n--></script>";	   
      }
   
#   }




$html = $html ."<input type='hidden' value='" . $q{'store_history'} . "' name='store_history'>";

$html = $html ."<input type='submit' value='Remove Selected Items' name='submit'><br><br>";


$html = $html .
'<table border="2" cellspacing="0" width="640">';

$html = $html .'<tr>';
$html = $html .'<td>';
$html = $html . 'Remove';
$html = $html .'</td>';

$html = $html .'<td>';
$html = $html . 'Item';
$html = $html .'</td>';

$html = $html .'<td align="right">';
$html = $html . 'Unit Price';
$html = $html .'</td>';

$html = $html .'<td align="right">';
$html = $html . 'Quantity';
$html = $html .'</td>';

$html = $html .'<td align="right">';
$html = $html .'Totals';

$html = $html .'</tr>';

my $count=0;


foreach  my $first (sort keys %form_data)
   {
   my $last = $form_data{$first};



#while(my ($first,$last) = each(%form_data))
#   {
   my ($id,$add,$price,$weight,$m1,$menu_1,$m2,$menu_2,$m3,$menu_3) = split('\|',$first);

   $count++;
   
   $first =~ s/\n//;
   $first =~ s/\r//;
   
   
         
   if($q{&unconvert($first)} eq undef)
      {
	      
      #$html = $html .'<tr>';
 $html = $html .'<tr';      
          
#### patch four

if($q{'username'} eq 'blackandwhitegalleries')
{
            
$html .= &print_pics($id);
}

###########


 $html = $html .'>';       
      

      $html = $html .'<td valign="top">';

#$html = $html . $q{$first};


      $html = $html .'<input type="checkbox" name="' . $first . '" value="ON">';

      $html = $html .'</td>';

      $html = $html .'<td valign="top">';
      $html = $html . $add;
      
      if($m1 ne "")
         {
	     $html = $html . "<br>" . $m1 . ": " . $menu_1;
         }
      
      if($m2 ne "")
         {
	     $html = $html . "<br>" . $m2 . ": " . $menu_2;
         }
         
      if($m3 ne "")
         {
	     $html = $html . "<br>" . $m3 . ": " . $menu_3;
         }
            
      if($weight ne "")
         {
	     $html = $html . " (" . $weight . $weight_symbol . ")";
	     }
      
	  if($id ne "")
         {
	     $html = $html . "<br>$id";
	     }
	     ##############  patch five  ###################
if($q{'username'} eq 'blackandwhitegalleries')
   {
   $html .= &show_picture($id,$add);
   }
############################################
	     
      $html = $html .'</td>';
      
      $html = $html .'<td valign="top" align="right">';
      $html = $html . &tformat(($price));
      $html = $html .'</td>';
      
      $html = $html .'<td valign="top" align="right">';  
      $html = $html . sprintf($last);
      $html = $html .'</td>';

      $html = $html .'<td valign="top" align="right">';
      $html = $html . &tformat(($last * $price));

      $html = $html .'</td>';

$pay_item{$count}=$add;
$pay_code{$count} = $id;
$pay_price{$count} = $price;
$pay_qty{$count} = $last;
$pay_weight{$count} = $weight;
$pay_m1{$count} = $m1;
$pay_menu_1{$count} = $menu_1;
$pay_m2{$count} = $m2;
$pay_menu_2{$count} = $menu_2;
$pay_m3{$count} = $m3;
$pay_menu_3{$count} = $menu_3;

      
        $total = $total + ($last*$price);
        
        
        

#      $html = $html . "$total" ."xxxxxx" . ($last*$price) ;
      $html = $html .'</tr>';
      }
   else
      {
#	  $html = $html . "reduction";    
#      $total_weight = $total_weight - ($weight * $form_data{$first});
#      $total = $total - ($price * $form_data{$first});
###      $form_data{$first}="DEL";
      
###           if($weight ne "" && $weight > 0)
      #{
      #if($weight =~ /^-?\d/)
###      {
###      $total_weight = $total_weight - $weight;
###      } 
      
      
      }

print $html;
$html ='';         
   }

   
###### Item Total ###############
   
   
$html = $html .'<tr>';
$html = $html ."<td colspan='4'><p align='right'>Item Total&nbsp;&nbsp;</p>";
##$html = $html . &sformat($last);
$html = $html .'</td>';

##$html = $html .'<td>&nbsp;';
#$html = $html . $add;
##$html = $html .'</td>';

##$html = $html .'<td>&nbsp;';
#print $add;
##$html = $html .'</td>';

##$html = $html .'<td>&nbsp;';

#print &sformat(($price));
##$html = $html .'</td>';

$html = $html .'<td align="right">';
$html = $html . &tformat(($total));
$html = $html .'</td>';

$html = $html .'</tr>';   
  
   
######## Shipping ##################

if($total > 0)
   {
   &calc();
  
   }
else
   {
   $cost_of_stamps=0;
   $dtax=0; 	   
	   
   }

if($cur_postage ne "")
   {
   $html = $html .'<tr>';

   $html = $html ."<td colspan='4'>";
   
   if(index($cur_postage,'Select ') != 0)
      {
      $html = $html . "<p align='right'>Shipping&nbsp;&nbsp;</p>";	
      }
   else
      {
      $html = $html . "<p align='right'><font face='Arial' size='3' color='#FF6F1A'>Please select a shipping rate from the menu&nbsp;&nbsp;</font></p>";	
      }
   

   $html = $html .'<td align="right">';
   $html = $html . &tformat(($cost_of_stamps));
   $html = $html .'</td>';

   $html = $html .'</tr>';

   }
   
########  Tax Details ###############################

if($q{'sales_tax'} ne undef)
{

$html = $html .'<tr>';


$html = $html . "<td colspan='4'>";

 if(index($q{'sales_tax'},'Select ') != 0)
      {
      $html = $html . "<p align='right'>$sales_tax_label&nbsp;&nbsp;</p>";	
      }
   else
      {
      $html = $html . "<p align='right'><font face='Arial' size='3' color='#FF6F1A'>Please select $sales_tax_label or VAT from the menu&nbsp;&nbsp;</font></p> ";	
      }

$html = $html .'</td>';

#$html = $html .'<td></td>';

$html = $html .'<td align="right">';
$html = $html . &tformat(($dtax));
$html = $html .'</td>';

$html = $html .'</tr>';

}

#######  Grand Total ########################


$html = $html .'<tr>';
$html = $html ."<td colspan='4'><p align='right'>Order Total&nbsp;&nbsp;</p>";
##$html = $html . &sformat($last);
$html = $html .'</td>';

##$html = $html .'<td>&nbsp;';
#$html = $html . $add;
##$html = $html .'</td>';

##$html = $html .'<td>&nbsp;';
#print $add;
##$html = $html .'</td>';

##$html = $html .'<td>&nbsp;';

#print &sformat(($price));
##$html = $html .'</td>';

$html = $html .'<td align="right">';
$html = $html . &tformat(($final_bill));
$html = $html .'</td>';

$html = $html .'</tr>';



$html = $html . '</table><br>';


if($total_weight > 0)
{
$html = $html . "Total weight of the order is, $total_weight $weight_symbol<br>";



}

##### Patch Six #############



if($q{'username'} eq 'blackandwhitegalleries')
{
&error_messages($html);
	 
}


######### additonal drop down menu for userform

#if($q{'username'} eq 'bandwcompetition' )
#{

	
	#foreach my $rate (split ("\n", $postbox))
   #

#my %drop_down_3 = ();

#$drop_down_3{'0'} = $drop_down_3_title;


#my $sel=1;
	
#foreach my $choice (split ("\n", $drop_down_3))
#   {
#   $drop_down_3{$sel} = $choice;
#   $sel++;
#   }
   
#$html .= "<select name='drop_down_3' size='1'>";

#$sel=0;

#while($drop_down_3{$sel} ne undef)
#   {
    	      
#   $html = $html . "<option ";
#   if($q{'drop_down_3'} eq $drop_down_3{$sel})
#     {
#     $html = $html . "selected";	  
#     }
#   $html = $html . " value='$drop_down_3{$sel}'>$drop_down_3{($sel)}</option>";
#   $sel++; 
#   }
      
#$html = $html . "</select>";	    
      
   
#if($q{'drop_down_3'} eq '' || index($q{'drop_down_3'},'Select') == 0)
#   { 
     
#   $html = $html . "<br><input type='submit' value='Click to Continue' name='b7'>";
         
#   $html = $html . '</form></body></html>';print $html;exit; 
#   }
	

   
#if($q{'drop_down_3'} ne '')
#   {
#   $product_des .= " : $q{'drop_down_3'}";
#   }
#else
#   {
#   $short_product_des .= " :$q{'drop_down_3'}";
#   }
   
#}

#####################################################


######### Shipping Drop Down Menu ######################

if($POST{'0'} ne undef)
   {

   $html = $html . "<select name='shipping' size='1'>";

   my $n=0;
   my $previous = "";
   
   my $shipping_menu = "";
   my $shipping_count = 0;

   while($POST{$n} ne undef)
      {

      my $postage_record = $POST{$n};
      my ($delivery_method,$table,$post_rate) = split(',',$postage_record);

      if($delivery_method ne $previous)
         {
	      $shipping_count++;   
          $shipping_menu =  $shipping_menu . "<option ";
      
         if($cur_postage eq $delivery_method)
            {
	         $shipping_menu =  $shipping_menu . "selected";    
            }    
      
          $shipping_menu =  $shipping_menu . " value='$delivery_method'>$delivery_method</option>";
	      
         } 
         
      $previous = $delivery_method;

      $n++;  
      }  

   if($shipping_count>1)
      {
      $html = $html . "$shipping_count<option value='Select shipping'>Select shipping</option>";
      }   
      
   $html = $html . $shipping_menu;
         
   $html = $html . "</select> ";
 
   }

############ VAT Drop Down Menu #####################

if($TAX{'1'} ne undef)
   {
 
   $html = $html . "<select name='sales_tax' size='1'>";

   my $n=1;
   my $previous = "";


   if($TAX{'2'} ne undef)
      {
      $html = $html . "<option value='Select $sales_tax_label'>Select $sales_tax_label</option>";
      }

   while($TAX{$n} ne undef)
      {
    	      
      $html = $html . "<option ";
      if($q{'sales_tax'} eq $TAX{$n-1})
	     {
	     $html = $html . "selected";	  
	     }
	  
	  $html = $html . " value='$TAX{$n-1}'>$TAX{($n-1)} $TAX{($n)}" .'%' . "</option>";


      $n++;$n++; 
      }  

   $html = $html . "</select> ";
 
   }



#if($POST{'0'} ne undef || $TAX{'1'} ne undef)
#   {   
   

      
if($POST{'0'} ne undef || $TAX{'1'} ne undef)
   {
   if($single_rate > 2 || $no_of_posts > 1)
      {
      $html = $html ."<input type='submit' value='Calculate Totals' name='b6'>";
      }
   }

   
if($terms_and_conditions eq 'Yes')
      {
	   
      $html .= '<br><br><font face=\'Arial\' size=\'2\' >&nbsp;<input type="checkbox" name="agree_terms" value="Yes"';
      
      if($q{'agree_terms'} eq 'Yes')
    	 {
	     $html .= ' checked';
         }
         
	  $html .= '">&nbsp;I&nbsp;accept&nbsp;the&nbsp;';
	
	  $html .= "<strong><a href='" . $terms_and_conditions_url . "'>Terms and Conditions</a></strong></font><br><br>";
	  
	  
      if($q{'agree_terms'} ne 'Yes')
    	 {
	     $html = $html ."<input type='submit' value='Click to Continue' name='b7'>";
         }
      }   

   
  $html = $html . '</form>';


###########
#   my $output="";
   
#   local our %ssc;
#   my $n=0;
   
#   while(my ($first,$last) = each(%q))
#      {
#      my $temp =  $ssc{$n} . &uri_escape($first) . '_' . &uri_escape($last) . '&';		  
	  
#      if(length($temp)<4000)
#         {  
#         $ssc{$n} = $temp; 
#         }
#      else
#         {
#	     $n++;
#	     $ssc{$n} = &uri_escape($first) . '_' . &uri_escape($last) . '&';   
#         } 
#      }
      
#   my $m=0;      
#   while($ssc{$m} ne "")
#      {   
#      print "Set-Cookie: ssc$m=" . $ssc{$m} . ";\n";
#      $m++;
#      }
      
#   print "Set-Cookie: ssc$m=;\n";      
  
############################################


      
# if(length($save)>4096)
#   {  
#   $save = "";
   
#   $q{'add_to_order'} ="";
#   $q{'item_price'}="";
#   $q{'weight'}="";
#   $q{'id'} =""; 
#   $q{'qty'} =""; 
#   $q{'item_price'} =""; 
#   $q{'m1'} =""; 
#   $q{'menu_1'} =""; 
#   $q{'m2'} =""; 
#   $q{'menu_2'} ="";  
#   $q{'m3'} =""; 
#   $q{'menu_3'} ="";   
#   }
      
#####   print "Set-Cookie: Cust=" . $save . ";\n"; 
         
   print $html;   
      
            
   if($q{'shipping'} ne undef)
      {
	  $product_des = $product_des . $q{'shipping'} . ": " . $currency_symbol . $cost_of_stamps ."\r\n";  
	  $short_product_des = $short_product_des . $q{'shipping'} . ": " . $currency_symbol . $cost_of_stamps . "\r\n";   
        
      }   
      
   if($q{'sales_tax'} ne undef)
      {
	  $product_des = $product_des . $q{'sales_tax'} . ": " . $currency_symbol . $tax_total . "\r\n"; 
	  $short_product_des = $short_product_des . $q{'sales_tax'} . ": " . $currency_symbol . $tax_total . "\r\n";     
     
      }
   
   
   $product_des =~ s/&/&amp;/g;      
   $product_des =~ s/"/&quot;/g;

   $product_des =~ s/</&lt;/g;
   $product_des =~ s/>/&rt;/g; 
   
   $short_product_des =~ s/&/&amp;/g;      
   $short_product_des =~ s/"/&quot;/g;

   $short_product_des =~ s/</&lt;/g;
   $short_product_des =~ s/>/&rt;/g; 
      

   
 

####### Show Payment Buttons ######################
 
my $order_buttons ="";

if(($total > 0) && (index($q{'sales_tax'},'Select ') != 0) && (index($cur_postage,'Select ') != 0) && ($cur_postage ne "" || $POST{'0'} eq undef) && ($q{'sales_tax'} ne "" || $TAX{'1'} eq undef)) 

   {

   	   
 if($terms_and_conditions eq 'Yes' && $q{'agree_terms'} ne 'Yes')
  {
  print "<span style='background-color: rgb(255,255,255); color: rgb(255,0,0)'><font face='Arial' size='3' >
  <br>Please View and Accept the Terms and Conditions before continuing</font></span>"; 
  print $end;exit;
  } 

 
$order_buttons = "not_defined";	 
 
 
 	   
print"<table border='0'>";
print"<tr>";


if($worldpay eq "Yes")
   {
	   
$order_buttons = "defined";	
	   	   
print"<td>";   
   print'<form  method="POST" action="';

   print 'https://select.worldpay.com/wcc/purchase';

   print'">';

   print "<input type='hidden' name='instId' value='" . $instId . "'>";
   print "<input type='hidden' name='amount' value='$final_bill'>";
   print "<input type='hidden' name='cartId' value='". time . "'>";
   print "<input type='hidden' name='currency' value='" . $currency_code . "'>";
   print "<input type='hidden' name='testMode' value='" . $testMode ."'>";
     
   if($acc_Id ne "")
      {
      print "<input type='hidden' name='accId1' value = " . $acc_Id . "'>";
   #   print "<input type='hidden' name='authMode' value='" . $auth . "'>";
      }
   
   print "<input type='hidden' name='authMode' value='" . $auth . "'>";   
      
      
   if(length($product_des) < 255)
      {
	  $short_product_des = $product_des;   
      }   
           
      
   #$short_product_des =~ s/�/&#163;/g;
   
   #$product_des =~ s/�/&#163;/g;
   
   my $pound = '£';
      
 # $product_des =~ s/&amp;#163;/$pound/g;
   
 # $short_product_des =~ s/&amp;#163;/$pound/g;
 
# $product_des =~ s/&amp;#163;/$pound/g;
      

$short_product_des =~ s/&amp;#163;/$pound/g;


$product_des =~ s/&amp;#163;/$pound/g;
        
   print"<input type='hidden' name='desc' value='$short_product_des'>";
   
   print"<input type='hidden' name= 'MC_description' value='$product_des'>";

   print"<input type='submit' value='Pay by Credit/Debit Card (Worldpay)' name='submit2'>";

   print "</form> ";
print"</td>";
   }


if($pay_pal eq "Yes")
   {
   $order_buttons = "defined";	
   print"<td>";	   
   &paypal_button();
   print"</td>";
   }   


if($google_checkout eq "Yes")
   {
   $order_buttons = "defined";	
   print"<td>";	   
   &google_button();
   print"</td>";
   }   
   
if($barclay eq "Yes")
   {
   $order_buttons = "defined";	
   print"<td>";	   
   &epdq_button();
   print"</td>";
   }   
   
if($payoffline eq "Yes")
   {
   $order_buttons = "defined";	
   print"<td>";	   
   &payoffline_button();
   print"</td>";
   }  
   
   
if($authorizenet eq "Yes")
   {
   $order_buttons = "defined";		   
   print"<td>";	   
   &authorize_button();
   print"</td>";
   }     
   
      
if($nochex eq "Yes")
   {
   $order_buttons = "defined";	
   print"<td>";	   
   &nochex_button();
   print"</td>";
   }    

if($authorizenet_aim eq "Yes")
   {
   $order_buttons = "defined";	
   print"<td>";	   
   &authorizenet_aim_button();
   print"</td>";
   }       

if($authorizenet_aim_check eq "Yes")
   {
   $order_buttons = "defined";	
   print"<td>";	   
   &authorizenet_aim_check_button();
   print"</td>";
   }    
   
   
if($authorizenet_fargo_cc eq "Yes")
   {
   $order_buttons = "defined";	
   print"<td>";	   
   &fargo_cc_button();
   print"</td>";
   }       

if($authorizenet_fargo_check eq "Yes")
   {
   $order_buttons = "defined";	
   print"<td>";	   
   &fargo_echeck_button();
   print"</td>";
   }  
   
   
      
if($paypal_express eq "Yes")
   {
   $order_buttons = "defined";	
   
   print"<td align='center' valign='top'>";
   print"<p align='right'><font face='Arial' size='2'><strong>
   Save&nbsp;time.&nbsp;Checkout&nbsp;securely.&nbsp;<br>Pay without sharing your&nbsp;<br>financial information.&nbsp;</strong></font>";
   print"</td>";
   
   print"<td>";	   
   &paypal_express_button();
   print"</td>";
   }     
   
  
print"</tr></table>";

if($paypal_pro eq "Yes" || $paypal_pro_uk eq "Yes")
   {
   $order_buttons = "defined";	
   
   #print"<tr><td align='center' valign='top'>";  
   #print"<font face='Arial' size='2'><strong><br>&nbsp;----&nbsp;OR&nbsp;----</strong></font>";
   #print"</td>";   
   
   #print"<tr><td>";
   
 	   
   &paypal_pro_button();
   
   
   #print"</td></tr>";
   #print"</table>";    
    }

    
print "$k";    
     
}



if($order_buttons eq "not_defined")
   {
   if(!$ENV{'HTTP_HOST'} =~ /online-store/i) 	   
      {	   
      print "<span style='background-color: rgb(255,255,255); color: rgb(255,0,0)'><font face='Arial' size='3' ><br>No Payment Processors have been selected. Click on Setup 3 option in the setup program. Then select which Payment Method you wish to use.<br><br>For example, if you use PayPal Standard, Click Setup 3, Select PayPal Standard and the tick the PayPal Standard box.<br><br>Save shop.pl and upload the file to your server.</font></span>";
      }  
   else
      {
      print "<font face='Arial' size='3' ><br>The merchant has not yet selected a payment processor.<br><br>Click <strong><a href='https://www.online-store.co.uk/shop3/";
      
      print $q{'username'};
      
      print "/config.html'>Payments Setup</a></strong> to setup up a payment method.</font>";
      
      
            
print "<p><br><font face='Arial' size='3'><br><br>If you have already set up a payment processor.</font></p>
<p><font face='Arial' size='3'>Check you selected the 'Yes' option to enable the method.</font></p>
<p><font face='Arial' size='3'>Then clicked 'Save Changes'.</font></p>";
      

      }
   }

if($count == 0)
   {
   print "<span style='background-color: rgb(255,255,255); color: rgb(255,0,0)'><font face='Arial' size='3' ><br>No items are currently selected.  Please click 'Continue Shopping' and select the item you wish to purchase.<br></font></span>";
   }
elsif($total == 0)
   {
   print "<span style='background-color: rgb(255,255,255); color: rgb(255,0,0)'><font face='Arial' size='3' ><br>Your order total is currently $currency_symbol 0.00. We are unable to process orders of this amount. Please click 'Continue Shopping' and select a item  that wish to purchase.<br></font></span>";
   }

################################################

   
if($q{'username'} eq 'TestOnlineStore' && $order_buttons eq "defined")
   {
   print "<font face='Arial' size='3' ><br><hr>" .
   
   "<br>Only use this order form for test transactions." .
   
   
   "<br></font>";
          
	   
   }   
   
   
   
   
##### Print Form Footer ########################

print $end;





#-------------------------- Subroutines ------------------------------



sub end_cgi
   {
   my ($i) = @_;
	
   print"Content-Type: text/html\n\n$i\nend\n";

   exit;
   }

   
   
sub tformat
   {
   my ($value) = @_;
     	   
   if($currency_code ne 'JPY')
      {  	   
      $value = $currency_symbol . sprintf("%.2f",$value);   
      }
   else
      {
      $value = $currency_symbol . sprintf("%.0f",$value);	   
      }
         
   return $value;   
   }
   

sub sformat
   {
   my ($value) = @_;
     	   
   if($currency_code ne 'JPY')
      {  	   
      $value = sprintf("%.2f",$value);   
      }
   else
      {
      $value = sprintf("%.0f",$value);	   
      }
         
   return $value;   
   }
   
   
sub calc
{

    my $british_postal_rates=0;
    my $base_price=0;   
    my $compare_to = 0;
    #my $rate_amount=0; 

    my $n=0;
   
   $cost_of_stamps = 0;

   while($POST{$n} ne undef)
      {

      my $postage_record = $POST{$n};
      my ($delivery_method,$table,$post_rate) = split(',',$postage_record);

    
      $table =~ s/�/\$/g;   #replace � with $


      my $weight_or_money = "";

      my $greater_than = 0;

      if(index($table,'+') > -1)
         {

         $greater_than = 1;
         $table =~ s/\+//g;
         }


      if(index($table,'$') == -1)
         {
         $weight_or_money = "W";
         $table =~ s/W//g;
         $table =~ s/w//g;

         }
      else
         {
         $weight_or_money = '$';
         $table =~ s/\$//g;
         $table =~ s/�//g ;
         }


     $compare_to = 0;

     #convert to double  0 if error
     $compare_to = $table;


     $post_rate =~ s/�/\$/g;

     # new line , is this necessary?

     my $percent_or_money ="";

     if(index($post_rate,'%') != -1)
        {
        $percent_or_money = '%';
        $post_rate =~ s/\%//g;
        }
     else
        {
        $percent_or_money = '$';
        $post_rate =~ s/\$//g;
        $post_rate =~ s/�//g;
        }
 

        #$rate_amount = $post_rate; #remove ?

        #error rate amount =0;

        my $dual_variable = 0;

        #if (shipping.getSelectedItem().equals(delivery_method))

     if($cur_postage eq $delivery_method)
        {
        if ($weight_or_money eq '$')
           {
           $dual_variable = $total;
           }
        else
           {
           $dual_variable = $total_weight;
           }

         #  print "XXXX--$dual_variable--$compare_to--$greater_than<br>";      
              
        if (($dual_variable < $compare_to) || (($dual_variable >= $compare_to) && ($greater_than == 1)))
           {       
	            
	                
	       if ($percent_or_money eq '%')
              {
	     
              #$dual_variable = ($dual_variable * $rate_amount)/100;
              
              $dual_variable = ($total * $post_rate)/100;
              }
           else
              {
	        
              $dual_variable = $post_rate;
              }


         #     n = postage.countItems();
           $n=10000;
           $cost_of_stamps = $dual_variable;
      
           }
        }

#     print $table;
#     print "#";
#     print $weight_or_money;
#     print "#";
#     print $post_rate;
#     print "#";
#     print $percent_or_money;
#     print "Rate Amount $rate_amount";
#     print "#cost of stamps: ";
#     print $cost_of_stamps;
     $n++;
     }


    $vat = 0;
    #$dstamps = 0;

    my $svat = "0"; #//tax.getSelectedItem();

          $n=0;
          
          while($TAX{$n} ne undef)
             {            
	         if($TAX{$n} eq $tax_label)    
	            {
                $svat = $TAX{$n+1};
                }
             $n++;$n++;
             }
                            
          $vat = $svat;

###   if(!post)
###      {
###      cost_of_stamps = dstamps;
###      }
#

        if($total == 0)
           {
           $vat = 0;
           }

        $vat = $vat * 10;

        $dtax=0;

        
     
        #print "Content-Type: text/html\n\n"; 
        #$pay_price{'1'}"    
        # calc tax on each item
        # tax_item
        
      for($n=1;$pay_item{$n} ne undef;$n++)
          {
          $pay_tax{$n} = ($pay_price{$n}* ($vat))/1000;
          
          $pay_tax{$n} = &sformat($pay_tax{$n});
          $dtax += ($pay_qty{$n} * $pay_tax{$n});     
          } 
              
      if($vat_on_post eq "Yes")
         {   
         $dtax += ($cost_of_stamps * ($vat))/1000; 
         }
         
#        if($vat_on_post eq "Yes")
#           {
#           $dtax = (($total + $cost_of_stamps) * $vat)/1000;
#           }
#        else
#           {
#           $dtax = ($total * $vat)/1000;
#           }
        $dtax = &sformat(($dtax));
      
        $tax_total = $dtax;

        $final_bill=0;
        
        
      #    if($vat_on_post eq "Yes")
      #       {
      #       $final_bill = (($total + $cost_of_stamps) * (1000 + $vat))/1000;
      #       }
      #    else
      #       {
      #       $final_bill = (($total * (1000 + $vat))/1000)+ $cost_of_stamps;
      #       }
    
    
      $final_bill = $total + $cost_of_stamps + $dtax;
    
         
      $final_bill = &sformat(($final_bill));
      
      $cost_of_stamps = &sformat(($cost_of_stamps));
      
      
      
      #print("Final bill $final_bill");
      }


sub authorizenet_aim_button {
	########## Authorize AIM Button ######################
   

   print'
   <form  method="POST" action="';

   #print $cgi_script;
   print $secure_server . 'authorize_net_aim.pl';

   print'">';
   
   print "<input type='hidden' name='p' value='1'>";
   #print "<input type='hidden' name='shop_id' value='" . $q{'shop_id'}  . "'>";

   &print_authorize_fields();
   
   print"<input type='hidden' name='x_type' value='$authorizenet_x_type'>\r\n";
   
   print"<input type='hidden' name='x_method' value='CC'>\r\n";
   
   print "<input type='hidden' name='Action'   value='processform'>";

   print"<input type='submit' value='Authorize.Net Credit Card' name='submit'>";
   
   &shipping_fields();
    
   print "</form>\r\n";
#     }
   }

sub authorizenet_aim_check_button {
	########## Authorize AIM Button ######################
   

   print'
   <form  method="POST" action="';

   #print $cgi_script;
   print $secure_server . 'authorize_net_aim.pl';

   print'">';
   
   print "<input type='hidden' name='p' value='2'>";
   #print "<input type='hidden' name='shop_id' value='" . $q{'shop_id'}  . "'>";

   &print_authorize_fields();
   
   print"<input type='hidden' name='x_type' value='AUTH_CAPTURE'>\r\n";
   
   print"<input type='hidden' name='x_method' value='ECHECK'>\r\n";
   
   print "<input type='hidden' name='Action'   value='processform'>";

   print"<input type='submit' value='Authorize.Net ECheck' name='submit'>";
    
   &shipping_fields();
   
   print "</form>\r\n";
#     }
   }
   
sub fargo_cc_button {
	########## Fargo CC Button ######################
   

   print'
   <form  method="POST" action="';

   #print $cgi_script;
   print $secure_server . 'authorize_net_aim.pl';

   print'">';
   
   print "<input type='hidden' name='p' value='1'>";
   #print "<input type='hidden' name='shop_id' value='" . $q{'shop_id'}  . "'>";

   &print_authorize_fields();
   
   print "<input type='hidden' name='x_type' value='$authorizenet_x_type'>\r\n";
   
   print "<input type='hidden' name='x_method' value='CC'>\r\n";
   
   print "<input type='hidden' name='Action'   value='processform'>";

   print"<input type='submit' value='SecureSource Credit Cards' name='submit'>";
    
   &shipping_fields();
   
   print "</form>\r\n";
#     }
   }
   
   
sub fargo_echeck_button {
	########## Fargo echeck Button ######################
   

   print'
   <form  method="POST" action="';

   #print $cgi_script;
   print $secure_server . 'authorize_net_aim.pl';

   print'">';
   
   print "<input type='hidden' name='p' value='4'>";
   #print "<input type='hidden' name='shop_id' value='" . $q{'shop_id'}  . "'>";

   &print_authorize_fields();
   
   print"<input type='hidden' name='x_type' value='AUTH_CAPTURE'>\r\n";
   
   print"<input type='hidden' name='x_method' value='ECHECK'>\r\n";
   
   print "<input type='hidden' name='Action'   value='processform'>";

   print"<input type='submit' value='SecureSource ECheck' name='submit'>";
   
   &shipping_fields();
    
   print "</form>\r\n";
#     }
   }
   

      
sub paypal_button {
	########## PayPal Button ######################
	  
   print"

   <form  method='POST' action='https://$paypal_url/cgi-bin/webscr'> 
    
   <input type='hidden' name='cmd' value='_cart'>
   
   <input type='hidden' name='upload' value='1'>";
   
   &print_paypal_fields();

   print"<input type='submit' value='Secure Order Form (PayPal)' name='submit3'>\r\n";   
      
   print "</form>\r\n";
   }

   
sub google_button {
	########## PayPal Button ######################
	  
#

#Google vendor ID: 
#my $google_id = '546059749390063';
my $google_id = '609226616457813';

my $google_server = 'sandbox';

my $google_loc='en_US';

if($currency_code eq 'GBP')
   {
   $google_loc='en_GB';		
   }

   
   if($google_server eq 'live')
      {
      print"<form  method='POST' action='https://checkout.google.com/api/checkout/v2/checkoutForm/Merchant/$google_id'>\r\n"; 	
      print"<input type='image' name='Google Checkout' alt='Fast checkout through Google' src='https://checkout.google.com/buttons/checkout.gif?merchant_id=" .
      $google_id . "\&w=180&h=46&style=white&variant=text\&loc=" . $google_loc . "' height='46' width='180'>\r\n";
      }
   else
      {
      print"<form  method='POST' action='https://sandbox.google.com/checkout/api/checkout/v2/checkoutForm/Merchant/$google_id'>\r\n";
      print"<input type='image' name='Google Checkout' alt='Fast checkout through Google' src='http://sandbox.google.com/checkout/buttons/checkout.gif?merchant_id=" .
      $google_id . "\&w=180&h=46&style=white&variant=text\&loc=" . $google_loc . "' height='46' width='180'>\r\n";
      }
                                              

   
   
   my $n=1;
      
   my $items ="";
        
for($n=1;$pay_item{$n} ne undef;$n++)
    {

   if($pay_code{$n} ne '')
     {
     $pay_item{$n} = $pay_code{$n} . ': ' . $pay_item{$n};	
     }

print"<input type='hidden' name='item_name_$n' value='" .  $pay_item{$n} . "'>\n";
print"<input type='hidden' name='item_price_$n' value='" .  $pay_price{$n} . "'>\n";
print"<input type='hidden' name='item_quantity_$n' value='" .  $pay_qty{$n} . "'>\n";
print"<input type='hidden' name='item_currency_$n' value='" .  $currency_code . "'>\n";



my $name=$pay_item{$n};

my $desc = '';

if($pay_m1{$n} ne "")
   {
   $desc .= &convert("$pay_m1{$n}:$pay_menu_1{$n} - ");
   }

if($pay_m2{$n} ne "")
   { 
   $desc .= &convert("$pay_m2{$n}:$pay_menu_2{$n} - ");
   }

if($pay_m3{$n} ne "")
   {
   $desc .= &convert("$pay_m3{$n}:$pay_menu_3{$n} - ");
   }

print"<input type='hidden' name='item_description_$n' value='" .  $desc . "'>\n";	
  
  
}


if($q{'sales_tax'} ne undef)# && $vat ne "")
   {
   if($vat>0)
      {	 
      print"<input type='hidden' name='tax_rate' value='" .  &sformat($dtax) . "'>\n";
      print"<input type='hidden' name='tax_country' value='GB'>";
      }
   }

if($cost_of_stamps ne "" && $cur_postage ne "")
   {
   if($cost_of_stamps > 0)
     {	   
     print "<input type='hidden' name='ship_method_name_1' value='" . &convert($cur_postage) . "'>\n";
     print "<input type='hidden' name='ship_method_price_1' value='" .  &sformat($cost_of_stamps) . "'>\n";
     print "<input type='hidden' name='ship_method_currency_1' value='" . $currency_code . "'>\n";
     print "<input type='hidden' name='ship_method_area_1' value='world-area'>";     


     }
   }
   
   if($vat_on_post eq 'No')
      {
      print "<input type='hidden' name='checkout-flow-support.merchant-checkout-flow-support.tax-tables.default-tax-table.default-tax-rule-#.shipping-taxed' value='true'>";
      }
       
   print "</form>\r\n";
   }   
   
   
sub paypal_express_button {
	########## PayPal Button ######################
	
   
   
print"

<form  method='POST' action='$secure_server" . "paypal_pro.pl'> 

<input type='hidden' name='INVNUM' value='$unique_id'>

<input type='hidden' value='" . $q{'username'} . "' name='username'>
   
<input type='hidden' name='APIcall' value='SetExpressCheckout'>
    
<input type='hidden' name='currencyID' value='$currency_code'>
   
<input type='hidden' name='paypal_url' value='$paypal_url'>
   
<input type='hidden' name='ITEMAMT' value='" . &sformat(($total)) . 
    
"'>    
<input type='hidden' name='OrderTotal' value='$final_bill'>";
   
 #  if(length($product_des) < 511)
 #     {
 #     $short_product_des = $product_des;   
 #     }   
     

 #  print"<input type='hidden' name='short_desc' value='$short_product_des'>\r\n";
   
 
   
&shipping_fields();
   
for(my $n=1;$pay_tax{$n} ne undef;$n++)
   {
   my $m=$n-1;
   print("<input type='hidden' name='L_TAXAMT" .$m . "' value='" . &sformat($pay_tax{$n}) . "'>\r\n"); 
	           
   }
   
print"<input type='image' src='https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif' border='0' value='PayPal Express' name='submit4'>\r\n";   
      
print "</form>\r\n";
}
   
   
   #<input type='hidden' name='upload' value='1'>
   
sub paypal_pro_button {
	########## PayPal Button ######################

		
print"

<form  method='POST' action='$secure_server" . "paypal_pro.pl'>

<input type='hidden' name='INVNUM' value='$unique_id'>

<input type='hidden' value='" . $q{'username'} . "' name='username'>

<input type='hidden' name='currencyID' value='$currency_code'>

<input type='hidden' name='paypal_url' value='$paypal_url'>
   
<input type='hidden' name='ITEMAMT' value='" . &sformat(($total)) . 
    
"'>    

<input type='hidden' name='OrderTotal' value='$final_bill'>";
   
if(length($product_des) < 511)
   {
   $short_product_des = $product_des;   
   }   
     

print"<input type='hidden' name='short_desc' value='$short_product_des'>\r\n";
   
   
&shipping_fields();
   
  
for(my $n=1;$pay_tax{$n} ne undef;$n++)
   {
   my $m=$n-1;
   print("<input type='hidden' name='L_TAXAMT" .$m . "' value='" . &sformat($pay_tax{$n}) . "'>\r\n"); 
           
   } 
      

print

"<table border=0' cellpadding='4'>
   
<input type='hidden' name='APIcall' value='PrintDirectPaymentForm'>

<tr>
<td colspan='3'><font face='Arial' size='2'><strong>Click on logos to Pay by Credit/Debit Card</strong></font><br>&nbsp;</td>
</tr>
      
<tr>
<td colspan='1'>
<input type='image'  name='submit7' value='PrintDirectPaymentForm' src='credit_cards.jpg' border='0'alt='Credit Cards'>
</td>
<td><font face='Arial' size='2'>Credit/Debit Card</font></td>
</tr>

<tr>
<td>&nbsp;&nbsp;</td>
<td></td>
<td></td>
</tr>
  
</table>";

   
print "</form>\r\n";
   
print"

<form  method='POST' action='$secure_server" . "paypal_pro.pl'>

<input type='hidden' name='INVNUM' value='$unique_id'>
   
<input type='hidden' name='currencyID' value='$currency_code'>
   
  
<input type='hidden' name='paypal_url' value='$paypal_url'>
   
<input type='hidden' name='ITEMAMT' value='" . &sformat(($total)) . 
    
"'>    

<input type='hidden' name='OrderTotal' value='$final_bill'>";
   
if(length($product_des) < 511)
   {
   $short_product_des = $product_des;   
   }   
     

print"<input type='hidden' name='short_desc' value='$short_product_des'>\r\n";
   
   
&shipping_fields();
   
  
for(my $n=1;$pay_tax{$n} ne undef;$n++)
   {
   my $m=$n-1;
   print("<input type='hidden' name='L_TAXAMT" .$m . "' value='" . &sformat($pay_tax{$n}) . "'>\r\n"); 	           
   } 
  
   
   print"<table border=0' cellpadding='4'>
   <input type='hidden' name='APIcall' value='SetExpressCheckout'>
   <input type='hidden' value='" . $q{'username'} . "' name='username'>
   <tr>
   
   <td>
   <input type='image' src='https://www.paypal.com/en_US/i/btn/btn_xpressCheckout.gif' border='0' value='SetExpressCheckout' name='submit6'>
   </td>
   <td><font face='Arial' size='2'>Save&nbsp;time.&nbsp;Checkout&nbsp;securely. Pay without<br>
   sharing your&nbsp;financial information.&nbsp;</font></td>
   <td><font face='Arial' size='2'></font></td>
   </tr>
   
   </table>";

   print "</form>\r\n";
   
   }
   
   
   
   sub print_paypal_fields
{
	
   print "<input type='hidden' name='business' value='" . $business . "'>\n";

   print "<input type='hidden' name='bn' value='" . $bn . "'>\n";
   
   print "<input type='hidden' name='lc' value='" . $lc . "'>\n"; 
   
   print "<input type='hidden' name='currency_code' value='" . $currency_code . "'>\n";
   
   #print "<input type='hidden' name='upload' value='1'>\n";
   
   
   if($paypal_no_note eq "1")
      {
      print "<input type='hidden' name='no_note' value='" . $paypal_no_note . "'>\n";
      }
   else
      {
	  if($paypal_cn ne "")
	     {
		 print "<input type='hidden' name='cn' value='" . $paypal_cn . "'>\n";     
	     }
              	      
      }
      
      
   if($paypal_no_shipping eq "1" || $paypal_no_shipping eq "2")
      {
      print "<input type='hidden' name='no_shipping' value='" . $paypal_no_shipping . "'>\n";
      }   
          
         
   if($paypal_cancel_payment ne "")
      {   
      print "<input type='hidden' name='cancel_return' value='" . $paypal_cancel_payment . "'>\n";
      }
   
   if($paypal_return ne "")
      {
      print "<input type='hidden' name='return' value='" . $paypal_return . "'>\n";
      }
      
   if($paypal_image_url ne "")
      {
      print "<input type='hidden' name='cpp_header_image' value='" . $paypal_image_url . "'>\n";
      }   
   &shipping_fields();     
}
      




sub shipping_fields      
{      
my $n;
   
for($n=1;$pay_item{$n} ne undef;$n++)
    {
 
#on0
#on1
#os0
#os1

#$pay_m2{$count} = $m2;
#$pay_menu_2{$count};$pay_qty{$

   if($paypal_pro eq "Yes" || $paypal_express eq "Yes" || $paypal_pro_uk eq "Yes")
      {
      if($pay_m1{$n} ne "")
         {  
         print"<input type='hidden' name='pro_on0_$n' value='" . &convert($pay_m1{$n}) . "'>\n";
         print"<input type='hidden' name='pro_os0_$n' value='" . &convert($pay_menu_1{$n});
         print "'>\n";
         } 	

      if($pay_m2{$n} ne "")
         {  
         print"<input type='hidden' name='pro_on1_$n' value='" . &convert($pay_m2{$n}) . "'>\n";
         print"<input type='hidden' name='pro_os1_$n' value='" . &convert($pay_menu_2{$n});
         print "'>\n";
         }
      
      if($pay_m3{$n} ne "")
         {  
         print"<input type='hidden' name='pro_on2_$n' value='" . &convert($pay_m3{$n}) . "'>\n";
         print"<input type='hidden' name='pro_os2_$n' value='" . &convert($pay_menu_3{$n});
         print "'>\n";
         }
   
      print"<input type='hidden' name='pro_shipping' value='Shipping:" .  &convert($cur_postage) . "'>\n";
      }

   my $items_shipped;   

   if($n>1)
      {
      $items_shipped ="Shipping";
      }
   else
      {
      $items_shipped ="Shipping";	
      }

   print"<input type='hidden' name='quantity_$n' value='" .  &convert($pay_qty{$n}) . "'>\n";

   if($pay_m1{$n} eq "" && $pay_m2{$n} ne "")
      {
      $pay_m1{$n} = $pay_m2{$n};
      $pay_menu_1{$n} = $pay_menu_2{$n};	    
      $pay_m2{$n} = "";
      }

   if($pay_m2{$n} eq "" && $pay_m3{$n} ne "")
      { 
      $pay_m2{$n} = $pay_m3{$n};
      $pay_menu_2{$n} = $pay_menu_3{$n};
      $pay_m3{$n} = "";
      }   
   
   if($pay_m1{$n} eq "" && $pay_m2{$n} ne "")
      {
      $pay_m1{$n} = $pay_m2{$n};
      $pay_menu_1{$n} = $pay_menu_2{$n};	    
      $pay_m2{$n} = "";
      }   
   

   if($pay_m1{$n} ne "")
      {  
      print"<input type='hidden' name='on0_$n' value='" . &convert($pay_m1{$n}) . "'>\n";
      print"<input type='hidden' name='os0_$n' value='" . &convert($pay_menu_1{$n});
   
      if($pay_m3{$n} ne "")
         {
         print(&convert(" - $pay_m3{$n}:$pay_menu_3{$n}"));
         }
   
      print "'>\n";
      }
   

   if($pay_m2{$n} ne "")
      {  
	   
      print"<input type='hidden' name='on1_$n' value='" . &convert($pay_m2{$n}) . "'>\n";
      print"<input type='hidden' name='os1_$n' value='" . &convert($pay_menu_2{$n});
   
      if($pay_item{$n+1} eq undef)
         {	
         if($cost_of_stamps ne "" && $cur_postage ne "")
            {
            print(&convert(" -- $items_shipped: $cur_postage"));
            }
        }
      print "'>\n";
      }

   if($pay_item{$n+1} eq undef)
      {   
   

   if($pay_m1{$n} eq "" && $pay_m3{$n} eq "")
      {  
      if($cost_of_stamps ne "" && $cur_postage ne "")
         {   
	     print"<input type='hidden' name='on0_$n' value='$items_shipped'>\n";
         print"<input type='hidden' name='os0_$n' value='" . &convert($cur_postage) . "'>\n";	   
         }
      }    
   else
      {
      if($pay_m2{$n} eq "")
         {
         if($cost_of_stamps ne "" && $cur_postage ne "")
            {   
	        print"<input type='hidden' name='on1_$n' value='$items_shipped'>\n";
            print"<input type='hidden' name='os1_$n' value='" . &convert($cur_postage) . "'>\n";	   
            }
         }   
      }   
   
   }   
        
   print"<input type='hidden' name='item_number_$n' value='" .  &convert($pay_code{$n}) . "'>\n";


         
   print"<input type='hidden' name='item_name_$n' value='";


   print &convert($pay_item{$n});  
  
  
   if($pay_weight{$n} ne "")
      {
      print(" (" . $pay_weight{$n} . $weight_symbol . ")");
      }

   print "'>\n"; 
	     
 
   print"<input type='hidden' name='amount_$n' value='" .  &sformat($pay_price{$n}) . "'>\n";

   }


   if($q{'sales_tax'} ne undef)# && $vat ne "")
      {
      if($vat>0)
         {
	  	      	   
	     if($paypal_shipping ne "Yes")
	        {	        
            print"<input type='hidden' name='quantity_$n' value='1'>\n";
      
            print"<input type='hidden' name='item_number_$n' value=''>\n";

            print"<input type='hidden' name='item_name_$n' value='" .  &convert($q{'sales_tax'}) . "'>\n";
   
            print"<input type='hidden' name='amount_$n' value='" .  &sformat($dtax) . "'>\n";
            $n++;		
            }
            
         else
            {
		    print"<input type='hidden' name='tax_cart' value='" .  &sformat($dtax) . "'>\n";    
		          
            #for(my $m=2;$pay_item{$m} ne undef;$m++)
            #   {
	        #   print "<input type='hidden' name='tax_" . $m . "' value='0.00'>\n";     	              
            #   } 
            }     
         }      
      }

   if($cost_of_stamps ne "" && $cur_postage ne "")
      {
      if($cost_of_stamps > 0)
         {	   
	     if($paypal_shipping ne "Yes")
	        {   
	        print"<input type='hidden' name='quantity_$n' value='1'>\n";
      
            print"<input type='hidden' name='item_number_$n' value=''>\n";
         
            print("<input type='hidden' name='item_name_$n' value='" .  &convert($cur_postage));
      
            if($total_weight > 0)
               {
               print(" (Weight:". $total_weight . $weight_symbol . ")");
               }
 
           print "'>\n"; 
   
          print"<input type='hidden' name='amount_$n' value='" .  &sformat($cost_of_stamps) . "'>\n";
          }
      else
         {
	     print("<input type='hidden' name='custom' value='Shipping:" .  &convert($cur_postage));
      
         if($total_weight > 0)
            {
            print(" (Weight:". $total_weight . $weight_symbol . ")");
            }
 
         print "'>\n"; 
   
         print"<input type='hidden' name='shipping_1' value='" .  &sformat($cost_of_stamps) . "'>\n";    
	         
	   
                  
         for(my $m=2;$pay_item{$m} ne undef;$m++)
              {
	          print "<input type='hidden' name='shipping_" . $m . "' value='0.00'>\n";     
	              
              }
         }   
      }   
   }
	
}  
   


sub print_authorize_fields()
{
   my $n=1;
   my $items ="";
        
for($n=1;$pay_item{$n} ne undef;$n++)
    {
#  print"<input type='hidden' name='cur$n' value='GBP'>\n"; 
	    
	   
#print"<input type='hidden' name='qty$n' value='" .  . "'>\n";

#print"<input type='hidden' name='code$n' value='" . . "'>\n";

#print"<input type='hidden' name='desc$n' value='";
my $name=$pay_item{$n};


if($pay_m1{$n} ne "")
  {
  $name .= &convert("$pay_m1{$n}:$pay_menu_1{$n} - ");
  }

if($pay_m2{$n} ne "")
 { 
 $name .= &convert("$pay_m2{$n}:$pay_menu_2{$n} - ");
 
   }


if($pay_m3{$n} ne "")
  {
  $name .= &convert("$pay_m3{$n}:$pay_menu_3{$n} - ");
  }

#print &convert();  
  
#$items .= '<|>' . &convert($pay_code{$n}) . '<|>' . $name . '<|><|>' .&convert($pay_qty{$n}) . '<|>&sformat($pay_price{$n}) .'<|>';
#if($pay_weight{$n} ne "")
#  {
#  print(" (" . $pay_weight{$n} . $weight_symbol . ")");
#  }

#print "'>\n"; 
	     
 
#print"<input type='hidden' name='cost$n' value='" .   . "'>\n";

}


if($q{'sales_tax'} ne undef)# && $vat ne "")
   {
   if($vat>0)
      {	 
  
      print"<input type='hidden' name='x_tax' value='" .  &sformat($dtax) . "'>\n";
      }
   }

if($cost_of_stamps ne "" && $cur_postage ne "")
   {
   if($cost_of_stamps > 0)
      {	   
	  
      #if($total_weight > 0)
      #  {
      #  print(" (Weight:". $total_weight . $weight_symbol . ")");
      #  }
 
      print"<input type='hidden' name='x_freight' value='" .  &sformat($cost_of_stamps) . "'>\n";
      }
   }
   
   print "<input type=\"hidden\" name = \"x_amount\" value = \"$final_bill\">\r\n";
   
   
   
   
   if(length($product_des) < 255)
      {
      $short_product_des = $product_des;   
      }   
   else
      {
	  print"<input type='hidden' name='Long_Description' value='$product_des'>\r\n";  
      }     

   
         
   print"<input type='hidden' name='x_description' value='$short_product_des'>\r\n";
	
	
print "<input type=\"hidden\" name=\"x_test_request\" value=\"$authorizenet_testmode\">\n"; 	
	
}


sub epdq_button {
	########## Barclay ePDQ Button ######################
   

   print'
   <form  method="POST" action="';

   #print $cgi_script;
   print $secure_server . 'script.pl';

   print'">';
   
   print "<input type='hidden' name='barclay' value='true'>";
   #print "<input type='hidden' name='shop_id' value='" . $q{'shop_id'}  . "'>";
   
   my $n=1;
        
for($n=1;$pay_item{$n} ne undef;$n++)
    {
  print"<input type='hidden' name='cur$n' value='GBP'>\n"; 
	    
	    
print"<input type='hidden' name='qty$n' value='" .  &convert($pay_qty{$n}) . "'>\n";

print"<input type='hidden' name='code$n' value='" .  &convert($pay_code{$n}) . "'>\n";

print"<input type='hidden' name='desc$n' value='";

if($pay_m1{$n} ne "")
  {
  print(&convert("$pay_m1{$n}:$pay_menu_1{$n} - "));
  }

if($pay_m2{$n} ne "")
  {
  print(&convert("$pay_m2{$n}:$pay_menu_2{$n} - "));
  }


if($pay_m3{$n} ne "")
  {
  print(&convert("$pay_m3{$n}:$pay_menu_3{$n} - "));
  }

print &convert($pay_item{$n});  
  
  
if($pay_weight{$n} ne "")
  {
  print(" (" . $pay_weight{$n} . $weight_symbol . ")");
  }

print "'>\n"; 
	     
 
print"<input type='hidden' name='cost$n' value='" .  &sformat($pay_price{$n}) . "'>\n";

}


if($q{'sales_tax'} ne undef)# && $vat ne "")
   {
   if($vat>0)
      {	 
	  print"<input type='hidden' name='cur$n' value='GBP'>\n";    
	         
      print"<input type='hidden' name='qty$n' value='1'>\n";
      
      print"<input type='hidden' name='code$n' value='~WP_TAX'>\n";

      print"<input type='hidden' name='desc$n' value='" .  &convert($q{'sales_tax'}) . "'>\n";
   
      print"<input type='hidden' name='cost$n' value='" .  &sformat($dtax) . "'>\n";
      $n++;		
      }
   }

if($cost_of_stamps ne "" && $cur_postage ne "")
   {
   if($cost_of_stamps > 0)
      {	   
	  print"<input type='hidden' name='cur$n' value='GBP'>\n";    
	   
      print"<input type='hidden' name='qty$n' value='1'>\n";
      
      print"<input type='hidden' name='code$n' value='~WP_PNP'>\n";
         
      print("<input type='hidden' name='desc$n' value='" .  &convert($cur_postage));
      
      if($total_weight > 0)
        {
        print(" (Weight:". $total_weight . $weight_symbol . ")");
        }
 
      print "'>\n"; 
   
      print"<input type='hidden' name='cost$n' value='" .  &sformat($cost_of_stamps) . "'>\n";
      }
   }
   
   print "<input type='hidden' name='Action'   value='processform'>";

   print"<input type='submit' value='ePDQ Secure Order Form' name='submit'>";
    
   print "</form>\r\n";
#     }
   }
   
   
sub payoffline_button {
	########## PayOffLine ePDQ Button ######################
   

   print'
   <form  method="POST" action="';

   #print $cgi_script;
   print $secure_server . 'payoffline1.pl';

   print'">';
   
   print "<input type='hidden' name='payoffline' value='processform'>";
   #print "<input type='hidden' name='shop_id' value='" . $q{'shop_id'}  . "'>";
   
   my $n=1;
        
for($n=1;$pay_item{$n} ne undef;$n++)
    {
  print"<input type='hidden' name='cur$n' value='GBP'>\n"; 
	    
	    
print"<input type='hidden' name='qty$n' value='" .  &convert($pay_qty{$n}) . "'>\n";

print"<input type='hidden' name='code$n' value='" .  &convert($pay_code{$n}) . "'>\n";

print"<input type='hidden' name='desc$n' value='";

if($pay_m1{$n} ne "")
  {
  print(&convert("$pay_m1{$n}:$pay_menu_1{$n} - "));
  }

if($pay_m2{$n} ne "")
  {
  print(&convert("$pay_m2{$n}:$pay_menu_2{$n} - "));
  }


if($pay_m3{$n} ne "")
  {
  print(&convert("$pay_m3{$n}:$pay_menu_3{$n} - "));
  }

print &convert($pay_item{$n});  
  
  
if($pay_weight{$n} ne "")
  {
  print(" (" . $pay_weight{$n} . $weight_symbol . ")");
  }

print "'>\n"; 
	     
 
print"<input type='hidden' name='cost$n' value='" .  &sformat($pay_price{$n}) . "'>\n";

}


if($q{'sales_tax'} ne undef)# && $vat ne "")
   {
   if($vat>0)
      {	 
	  print"<input type='hidden' name='cur$n' value='GBP'>\n";    
	         
      print"<input type='hidden' name='qty$n' value='1'>\n";
      
      print"<input type='hidden' name='code$n' value='~WP_TAX'>\n";

      print"<input type='hidden' name='desc$n' value='" .  &convert($q{'sales_tax'}) . "'>\n";
   
      print"<input type='hidden' name='cost$n' value='" .  &sformat($dtax) . "'>\n";
      $n++;		
      }
   }

if($cost_of_stamps ne "" && $cur_postage ne "")
   {
   if($cost_of_stamps > 0)
      {	   
	  print"<input type='hidden' name='cur$n' value='GBP'>\n";    
	   
      print"<input type='hidden' name='qty$n' value='1'>\n";
      
      print"<input type='hidden' name='code$n' value='~WP_PNP'>\n";
         
      print("<input type='hidden' name='desc$n' value='" .  &convert($cur_postage));
      
      if($total_weight > 0)
        {
        print(" (Weight:". $total_weight . $weight_symbol . ")");
        }
 
      print "'>\n"; 
   
      print"<input type='hidden' name='cost$n' value='" .  &sformat($cost_of_stamps) . "'>\n";
      }
   }
   
   print "<input type='hidden' name='Action'   value='processform'>";

   print"<input type='submit' value='PayOffline Secure Order Form' name='submit'>";
    
   print "</form>\r\n";
#     }
   }
   

         
sub authorize_button {
   ########## AuthorizeNet Button ######################
   
   print'
   <form  method="POST" action="';

   print "$server";

   print"\">\r\n";
    
   print "<input type=\"hidden\" name = \"x_Amount\" value = \"$final_bill\">\r\n";
    print "<input type=\"hidden\" name = \"username\" value = \"$q{'username'}\">\r\n";  
   
   
   
   if(length($product_des) < 255)
      {
      $short_product_des = $product_des;   
      }   
   else
      {
	  print"<input type='hidden' name='Long_Description' value='$product_des'>\r\n";  
      }     

   print"<input type='hidden' name='X_Description' value='$short_product_des'>\r\n";

   print"<input type='hidden' name='x_Version' value='3.1'>\n";
   

   print"<input type='submit' value='Secure Order Form (Authorize.Net)' name='submit'>\r\n";
    
   print "</form>\r\n";
   }
	
   
sub nochex_button {
	########## NoChex Button ######################
   

   print'
   <form  method="POST" action="';

   #print 'https://www.nochex.com/nochex.dll/checkout';
   print 'https://secure.nochex.com/';

   print'">';
   
   
   my $item_no = 0;
   print "<input type='hidden' name='email' value='" . $nochex_email . "'>";
   print "<input type='hidden' name='ordernumber' value='" . time . "'>";
   print "<input type='hidden' name='amount' value='" . $final_bill . "'>";
   
   if($nochex_logo  ne "")
      {
      print "<input type='hidden' name='logo' value='" . $nochex_logo . "'>";
      }
   
   
   if($nochex_return  ne "")
      {
      print "<input type='hidden' name='returnurl' value='" . $nochex_return . "'>";
      }
      
      
   if($nochex_cancel ne "")
      {
      print "<input type='hidden' name='cancelurl' value='" . $nochex_cancel . "'>";
      }
   
   
   
#   "&amount=" + pounds(grand_total);
   
   my $description = "";


   while(my ($first,$last) = each(%form_data))
      {
      $item_no++;
      
      my ($id,$add,$price,$weight,$m1,$menu_1,$m2,$menu_2,$m3,$menu_3) = split('\|',$first);
      

      $first =~ s/\n//;
      $first =~ s/\r//;
         
      my $product_menu = "";
         
      if($m1 ne ""){$product_menu = $product_menu . "[" . $m1 . ":" . $menu_1 . "] ";}
      if($m2 ne ""){$product_menu = $product_menu . "[" . $m2 . ":" . $menu_2 . "] ";}
      if($m3 ne ""){$product_menu = $product_menu . "[" . $m3 . ":" . $menu_3 . "] ";}
         
      $description = $description .
      
      "$id $add $product_menu (Qty: $last) (Cost per item: $price)  ";
      }
     
   $item_no++;

#### form ###################
   


   if($cur_postage ne "" && $total > 0 && $POST{'1'} ne undef) 
      {
	      
	  $description = $description . 
      "($cur_postage: $cost_of_stamps)\n  ";
          
      }     

   $item_no++;

#### form ######################
   
   if($tax_label ne "" && $total > 0 && $TAX{'1'} ne undef)
      { 
	  	  $description = $description . 
      "$tax_label $dtax\n";    
	      
      }        

$description = &convert($description);

   print "<input type='hidden' name='description' value='" . $description . "'>";

   print"<input type='submit' value='Secure Order Form (Nochex)' name='submit'>";
    
   print "</form> ";
#     }
   }


# sub g_value
#    {
#     local ($rec,$field)=@_;

#     $zz=0;
#     $yy=0;

#	   $rec = $rec + ",,,,,,,,,";

#	   for($nn=1;$nn<$field;$nn++)
#	     {
#                   $zz=index($rec,',',$zz)+1;
#       }

#         $yy = index($rec,',',$zz);
#           $rec= substr($rec,$zz,$yy);
#
#	   return $rec;
#     }


sub convert2
   {
   my ($html_info)= @_;
#   $html_info =~ s/&/&amp;/g;      
   $html_info =~ s/"/&quot;/g;

   $html_info =~ s/</&lt;/g;
   $html_info =~ s/>/&gt;/g; 
   
   $html_info =~ s/'/&#39;/g;	
   
   $html_info =~ s/�/&#163;/g;
   
  # $html_info =~ s/�/chr(163)/g;
   
   $html_info =~ s/�//g;
   
   $html_info =~ s/�/&euro;/g;
    
  	
   $html_info =~ s/�/&yen;/g; 
   
   return($html_info);
   }


sub convert
   {
   my ($html_info)= @_;
#   $html_info =~ s/&/&amp;/g;      
#   $html_info =~ s/"/&quot;/g;

#   $html_info =~ s/</&lt;/g;
#   $html_info =~ s/>/&gt;/g; 	
   #$html_info =~ s/�/&#8364;/g; 
   
   return($html_info);
   }
   
sub unconvert
   {
   my ($html_info)= @_;
#   $html_info =~ s/&amp;/&/g;      
#   $html_info =~ s/&quot;/"/g;

#   $html_info =~ s/&lt;/</g;
#   $html_info =~ s/&gt;/>/g;
   #$html_info =~ s/&#8364;/�/g;  	
   return($html_info);
   }
   
   

sub scan
   {
   my $testc=0;
       

   my ($cc_number) = @_;

	   
   my $new_ccnumber="";

   my $cclen = length($cc_number);
       
   if((index($cc_number,'$') != -1) || (index($cc_number,'�') != -1)  || (index($cc_number,'&#163;') != -1)  || (index($cc_number,'&euro;') != -1)   || (index($cc_number,'&yen;') != -1))
      {
        
      my $startc = index($cc_number,'$')+1;

      #if($startc==0)
      #   {
      #   $startc = index($cc_number,"�")+1;
      #
      #   }

      if($startc==0)
         {
         $startc = index($cc_number,'&#163;')+6;
         }   
         
      if($startc==5)
         {
         $startc = index($cc_number,'&euro;')+6;
         } 
         
      if($startc==5)
         {
         $startc = index($cc_number,'&yen;')+5;
         }   
         
                         
      for(my $n=$startc;$n<$cclen;$n++)
         {
         my $tc = substr($cc_number,$n,1);
 
         if($tc eq "0" || $tc eq "1" || $tc eq "2" || $tc eq "3" || $tc eq "4" || $tc eq "5" || $tc eq "6" || $tc eq "7" || $tc eq "8" || $tc eq "9" || $tc eq ".")
            {
            $new_ccnumber = $new_ccnumber . $tc;
            }
         else
            {
            $n = $cclen;
            }
         }    
          
      }
      
      #if((index($cc_number,'-$') != -1) || (index($cc_number,'-�') != -1) ||  || (index($cc_number,'-&#163;') != -1))
      #   {
	  #    return -$new_ccnumber; 
      #   }   
      
   return $new_ccnumber;       	
   
   }



# Subroutine to handle basic decoding of URL data.
sub url_decode {
    my ($s) = @_;

    # Translate + to space, and %XX to the character code.

    $s =~ tr/+/ /;
    $s =~ s/%([0-9A-F][0-9A-F])/pack("C",oct("0x$1"))/gie;
    return $s;
}

#sub addr_to_host {

    
#    local($ip_address) = $_[0];
#    $ip_address =~ s/^\s+|\s+$//g;
#    local(@bytes) = split(/\./, $ip_address);
#    local($packaddr) = pack("C4",@bytes);
#    local($host_name) = (gethostbyaddr($packaddr, 2))[0];
#    return($host_name);
#}


sub uri_escape {
	my $text = $_[0];
	return undef unless defined $text;

	# Build a char to hex map
	my %escapes = ();
	for (0..255) {
		$escapes{chr($_)} = sprintf("%%%02X", $_);
	}

	# Default unsafe characters.  RFC 2732 ^(uric - reserved)
	$text =~ s/([\%])/$escapes{$1}/g;
    #$text =~ s/([\'\0\?\"\+\;\,\=\&\:])/$escapes{$1}/g;
    $text =~ s/([\.\'\0\�\?\"\+\;\,\=\&\:\_\r\n])/$escapes{$1}/g;
    
	$text =~ s/ /\+/g;


	$text;
}

sub uri_unescape
   {
   my ($s) = @_;
   $s =~ s/\+/ /g;
   $s =~ s/%([0-9A-Fa-f]{2})/chr(hex($1))/eg; 
	
   return($s);
   }

sub decode_base63 ($)
{
    local($^W) = 0; # unpack("u",...) gives bogus warning in 5.00[123]
    use integer;

    my $str = shift;
    $str =~ tr|A-Za-z0-9+=/||cd;            # remove non-base64 chars
    if (length($str) % 4) {
	end_cgi("Length of base64 data not a multiple of 4")
    }
    $str =~ s/=+$//;                        # remove padding
    $str =~ tr|A-Za-z0-9+/| -_|;            # convert to uuencoded format
    return "" unless length $str;

    ## I guess this could be written as
    #return unpack("u", join('', map( chr(32 + length($_)*3/4) . $_,
    #			$str =~ /(.{1,60})/gs) ) );
    ## but I do not like that...
    my $uustr = '';
    my ($i, $l);
    $l = length($str) - 60;
    for ($i = 0; $i <= $l; $i += 60) {
	$uustr .= "M" . substr($str, $i, 60);
    }
    $str = substr($str, $i);
    # and any leftover chars
    if ($str ne "") {
	$uustr .= chr(32 + length($str)*3/4) . $str;
    }
    return unpack ("u", $uustr);
}


sub unattached_pics
{

my %list_of_frames;
my $frame_count=0;

      ###### aquire list of frames ######   
      
      foreach  my $efirst (sort keys %form_data)
         {

	     
         my $elast = $form_data{$efirst};

         my ($eid) = split('\|',$efirst);
   
         my $ps = index($eid,':');
         
         my $eframe_id = substr($eid,0,$ps); 
         
         if($eid =~ /FL/i || $eid =~ /FP/i)
	        {
		    $frame_count++;
            $list_of_frames{$eframe_id} = $frame_count;
	        }
         }
      
      foreach  my $first (sort keys %form_data)
         {
         my $last = $form_data{$first};

         my ($id,$add,$price,$weight,$m1,$menu_1,$m2,$menu_2,$m3,$menu_3) = split('\|',$first);
         
         if($id =~ /PP/i || $id =~ /LP/i)
            {
           
	        my $ps = index($id,':');    
	            
            my $frame_id = substr($id,0,$ps);    
  
            if($list_of_frames{$frame_id} eq undef && $frame_id ne '0') 
	           {
		       #$unassigned++;    
		       $id =~ s/$frame_id/0/;    
		                 
		       my $update = $id .'|' . $add .'|' . $price .'|' . $weight .'|' .  $m1 .'|' . $menu_1  .'|' .  $m2 .'|' . $menu_2  .'|' .  $m3 .'|' . $menu_3;
                     		             
		       $form_data{$update} = $last;   
		       delete($form_data{$first});

               }
            }
         }
         
}
   
sub set_frame_id
{
     if($q{'id'} =~ /FL/i || $q{'id'} =~ /FP/i)
         {
	         
	     if($cookie_hash{'frame_no'} eq '')
            {
            $cookie_hash{'frame_no'} = '0';
            }     
            
         $cookie_hash{'frame_no'} ++;
	         
	     $q{'id'} = "$cookie_hash{'frame_no'}: $q{'id'}"; 
         
	     ### search for compatible pictures : frame id 0 ###
	     
	     
	     my $pos = index($q{'id'},'F');
         
         my $num_of_pics = substr($q{'id'},$pos+2,1);
          
         my $pics_in_frame = 0;
	     
	     foreach  my $first(sort keys %form_data)
            {
            my $last = $form_data{$first};

            my ($id,$add,$price,$weight,$m1,$menu_1,$m2,$menu_2,$m3,$menu_3) = split('\|',$first);
   
            if(($id =~ /PP/i && $q{'id'} =~ /FP/i) || ($id =~ /LP/i  && $q{'id'} =~ /FL/i))
               {
               #my $pos = index($id,':');
            
               #if($pos >0)
               #   {
	               
	              my $ps = index($id,':');  
                  
	              my $frame_id = substr($id,0,$ps);    
  
	              if($frame_id eq '0' && $pics_in_frame < $num_of_pics)    
	                 {
		                 
		             $id =~ s/0/$cookie_hash{'frame_no'}/;    
		                 
		             my $update = $id .'|' . $add .'|' . $price .'|' . $weight .'|' .  $m1 .'|' . $menu_1  .'|' .  $m2 .'|' . $menu_2  .'|' .  $m3 .'|' . $menu_3;
                     		             
		             $form_data{$update} = $last;   
		             delete($form_data{$first});
		             $pics_in_frame++;    
                     }
	               
               #   }
               }
            }

            
         }
      
           
         
      #### Find number of pictures assigned to each frame (if any)
      
      foreach  my $first (sort keys %form_data)
         {
         my $last = $form_data{$first};

         my ($id,$add,$price,$weight,$m1,$menu_1,$m2,$menu_2,$m3,$menu_3) = split('\|',$first);
   
         if($id =~ /PP/i || $id =~ /LP/i)
            {
          #  my $pos = index(':',$id);
            
          #  if($pos >0)
          #  {
            my $ps = index($id,':');  
	          
            my $frame_id = substr($id,0,$ps);    
  
	       if($portraits{$frame_id} eq '')    
	          {
		      $portraits{$frame_id} = 0; 
              }
	       $portraits{$frame_id}++; 
           # }
            
            }
         }     
  
      #### Find Frames with space for picures
         
      my $found = 'no';
      
      my $frame_available = 'no';
      
      foreach  my $first (sort keys %form_data)
         {
         my $last = $form_data{$first};
         
         my ($id,$add,$price,$weight,$m1,$menu_1,$m2,$menu_2,$m3,$menu_3) = split('\|',$first);
         
         if(($id =~ /FP/i && $q{'id'} =~ /PP/i) || ($id =~ /FL/i  && $q{'id'} =~ /LP/i))
             {
             my $pos = index($id,'F');
         
             my $num_of_pics = substr($id,$pos+2,1);
         
             $pos = index($id,':');
      
             my $frame_id = substr($id,0,$pos);    
             
             ## check for frames with on pictures assigned or less than max number of pictures
      
             if(($portraits{$frame_id} < $num_of_pics) || $portraits{$frame_id} eq '') 
                {
                $active_frame= $frame_id;
                
                $frame_available = 'yes';
                
                last;
                }
             }      
         }     
             
         
      if($q{'id'} =~ /LP/i || $q{'id'} =~ /PP/i)
         {
	         
	     if($cookie_hash{'pic_no'} eq '')
            {
            $cookie_hash{'pic_no'} = '0';
            }     
            
         $cookie_hash{'pic_no'} ++;
	         
	     $q{'pic_no'} =  $cookie_hash{'pic_no'};
	     
	     $q{'id'} = "$active_frame:$cookie_hash{'pic_no'} - $q{'id'}";
	     	     
	     #$q{'id'} = "$cookie_hash{'frame_no'}:$cookie_hash{'pic_no'}- $q{'id'}";
	     
         }
         
                        

 }  

 
sub set_gallery_cookies
{ 
 
if($cookie_hash{'frame_no'} eq '')
   {
   $cookie_hash{'frame_no'} = '0';
   }

print "Set-Cookie: frame_no=" . $cookie_hash{'frame_no'} . ";\n";  


if($cookie_hash{'pic_no'} eq '')
   {
   $cookie_hash{'pic_no'} = '0';
   }

print "Set-Cookie: pic_no=" . $cookie_hash{'pic_no'} . ";\n";  

}

 
sub print_pics
   {
   my ($id) = @_;
   my $html = '';
   
     if($id =~ /FL/i || $id =~ /FP/i)
         {
	         
       
	         
	     $html .= ' style="font-weight: bold; font-family: Arial; font-size: 14';
	        
      my $pos = index($id,'F');
         
      my $num_of_pics = substr($id,$pos+2,1);
      
        my $ps = index($id,':'); 
      
      my $frame_id = substr($id,0,$ps);
          
      my $pics_in_frame = 0;
	     
      foreach  my $first(sort keys %form_data)
         {
        
         my ($pic_id) = split('\|',$first);
   
         if($pic_id =~ /PP/i || $pic_id =~ /LP/i)
           {

            my $ps = index($pic_id,':'); 
	        my $pic_frame_id = substr($pic_id,0,$ps);    
  
            if($frame_id eq $pic_frame_id && $pics_in_frame < $num_of_pics)    
               {
               $pics_in_frame++;    
               }
            }
         }
	  
      if($pics_in_frame < $num_of_pics)
	     {
		 my $pics_to_go = $num_of_pics - $pics_in_frame; 
		 if($find_error ne 'yes')
		    {
            $html .= '; color: rgb(255,0,0)';
            }
         $find_error = 'yes';
	     }      
           
	     
	   #if($check_id eq $id)
	   #     {
	   #     $html .= '; color: rgb(255,0,0)';
       #    }
	     $html .= '"'; 
            
         }
      else
         {
	     $html .= ' style="font-weight: normal; font-family: Arial; font-size: 14; font-style: italic';
	     
	     my $ps = index($id,':'); 
	       	     
	     my $test_pic_id = substr($id,0,$ps);  
            
        if($test_pic_id eq '0')
           {
	       if($find_error ne 'yes')
		      {
              $html .= '; color: rgb(255,0,0)';
              }
           $find_error = 'yes';
    
           }
	     
             $html .= '"'; 
         }
         
         
   return $html;
   }


sub show_picture
   {
   my ($id,$add_now) = @_;
   my $html = '';

   
if($id =~ /PP/i || $id =~ /LP/i)
   {
   my $link='';
	              
   ($link,$add_now) = &find_link($id,$add_now);
                           
     my $ps = index($id,':');  
   my $tpic_frame_id = substr($id,0,$ps);    
  
   if($tpic_frame_id eq '0')    
      {
               
      my $n_pic = $add_now; #substr($tadd,0,$n_pos);    
                 
     # $n_pic =~ s/ /-/g;
                                    
      if($id =~ /PP/i && !($id =~ /LPP/i))
         {
         $html .= "<br><img src='$link" . $n_pic  . ".jpg' width='66' height='100'>";
         }
      else
         {
         $html .= "<br><img src='$link" . $n_pic . ".jpg' width='100' height='66'>";                  
         }
      }
    return $html;  
   }   
   
   
   
 if($id =~ /FL/i || $id =~ /FP/i)
         { 
	     $html .= "<br>";    
	            
         my $vertical =' ';
                 
         if($id =~ /538FL2/i || $id =~ /876FL2/i || $id =~ /1064FP2/i || $id =~ /719FL3/i || $id =~ /1268FP3/i || $id =~ /1270FL6/i)
            {
	        $vertical = '<br><br>';  
            }
	     
	     
	     my $tpos = index($id,'F');
         
         my $tnum_of_pics = substr($id,$tpos+2,1);
         
         my $ps = index($id,':'); 
      
         my $tframe_id = substr($id,0,$ps);
          
         foreach  my $tfirst(sort keys %form_data)
            {
        
            my ($tpic_id,$tadd) = split('\|',$tfirst);
   
            if($tpic_id =~ /PP/i || $tpic_id =~ /LP/i)
               {
	           my $link='';
	              
	           ($link,$tadd) = &find_link($tpic_id,$tadd);
                           
	           my $ps = index($tpic_id,':'); 

               my $tpic_frame_id = substr($tpic_id,0,$ps);    
  
               if($tframe_id eq $tpic_frame_id)    
                 {
	             $tnum_of_pics--;    
         
                 my $n_pic = $tadd; #substr($tadd,0,$n_pos);    
                 

                        

	                 
	             if($tpic_id =~ /PP/i  && !($tpic_id =~ /LPP/i))
                    {
                    $html .= "<img src='$link" . $n_pic  . ".jpg' width='66' height='100'>$vertical";
                    }
                 else
                    {
	                $html .= "<img src='$link" . $n_pic . ".jpg' width='100' height='66'>$vertical";                  
                    }
                 }
              }
                    
         }
         
  #       for(my $n=$tnum_of_pics;$n>0;$n--)
  #            {
  #	          if($id =~ /FP/i)
  #                  {
  #                  $html .= "<img src='http://www.online-store.co.uk/spacer.gif' width='66' height='100' border='1'>$vertical";
  #                  }
  #               else
  #                  {
  #	                $html .= "<img src='http://www.online-store.co.uk/spacer.gif' width='100' height='66' border='1'>$vertical";                  
  #                  }    
  #            }           

}


return $html;

}


sub find_link
{
my ($tpic_id,$add) = @_;
my $link='';
	
	
              if($tpic_id =~ /SC1/i)  #Stephen Cawston
	              {
		          $link='http://www.theblackandwhitegalleries.com/portfolio/stephencawston/files/';
		          
		          $add =~ s/Black Bird Landscape/Black Sun 2 Landscape/;	         
		          
		          $add =~ s/^Grumeti River 2 Portrait BW/Grumeti River 2 Landscape BW/;
		          $add =~ s/^Grumeti River 1 Portrait BW/Grumeti River 1 Landscape BW/;
		          
		          #$add =~ s/^Lobo Bull 10 Landscape BW/Lobo Bull 10 Portrait BW/;
	
		          $add =~ s/ /-/g;      
		          $add=lc($add);
		          } 
	           	           
	          if($tpic_id =~ /SC2/i)
	              {
		          $link='http://www.theblackandwhitegalleries.com/portfolio/stephencawston/stephencawston_colour/files/';
		          
		          $add =~ s/Black Bird Landscape/Black Sun 2 Landscape/;
		          $add =~ s/^Come on Portrait C/Come on Landscape C/;
		          $add =~ s/^Famous Fairy Portrait C/Famous Fairy Landscape C/;
		          $add =~ s/^Lake Mayara/Lake Manyara/;
		          
		         
		          
		          $add =~ s/ /-/g;      
		          $add=lc($add);        
	              } 
        
	           
	           if($tpic_id =~ /LQ1/i)   #Li Quan
	              {
		              
		          $add =~ s/Portrait Portrait/Portrait/;    
		              
		          $link='http://www.theblackandwhitegalleries.com/portfolio/liquan/files/';
		          
		          $add =~ s/^World in my eyes/World in my eyes Landscape BW/;
		          $add =~ s/ /-/g;      
		          $add=lc($add);   
	              } 
	           	           
	          if($tpic_id =~ /LQ2/i)
	              {
		          $link='http://www.theblackandwhitegalleries.com/portfolio/liquan/liquan_colour/files/';  
		          
		          $add =~ s/^Gente Touch 1 Landscape C/Gentle Touch Landscape C/;
		          $add =~ s/^Rapiers Drawn 1 Landscape C/Rapiers Drawn 1Landscape C/;
		          $add =~ s/^Shadows Landscape C/Shadows Landscape C /;
		          $add =~ s/^Soft Touch Portrait C/soft-touch-portrait-C/;
		          
	              $add =~ s/ /-/g;      
		          $add=lc($add); 
		          } 
	              
 
	          if($tpic_id =~ /PT1/i)  #Paul Thomas
	              {
                   $add =~ s/^For Her Portrait BW/For Her Portrait BW /;
                   
                   $add =~ s/^Tender Kiss BW/Tender Kiss Portrait BW/;
                       
		          $link='http://www.theblackandwhitegalleries.com/portfolio/paulthomas/files/';
		          
	              $add =~ s/ /-/g;      
		          $add=lc($add); 
		          } 
	           	           
	          if($tpic_id =~ /PT2/i)
	              {
		                        
		          $link='http://www.theblackandwhitegalleries.com/portfolio/paulthomas/paulthomas_colour/files/';
		          $add =~ s/^Lily Down Portrait C/Lily Down Portarait C/;
		          $add =~ s/^Soft white Portrait C/Soft White Portrait C/;
		          $add =~ s/^Yellow Dew Portrait C/Yellow Dew Portarit C/;
		          
		          
		          $add =~ s/ /-/g;      
		          $add=lc($add);    
	              }    
	                
 
	          if($tpic_id =~ /STH1/i)  #StephenTaylor-Haines
	              {
		          $link='http://www.theblackandwhitegalleries.com/portfolio/StephenTaylor-Haines/files/';
		          $add =~ s/^Battersea Nights Landscape BW/Battersea Night Landscape BW/;
		          $add =~ s/^Blackfriars Pillers Portrait BW/Blackfriars Pillars Portrait BW/;
		          #$add =~ s/^Embankment Dreams Portrait BW/Embankment On n Off Portrait BW/;
		          $add =~ s/^The Grenadier Guards Portrait BW/The Grenadier Guardsl Portrait BW/;
		          $add =~ s/^Waiting Powerhouse Landscape C/Waiting Powerhouse Landscape BW/;
		          
		         # $add =~ s/^Armada Landscape BW/Armada\%20Landscape\%20BW/;
     
	              $add =~ s/ /-/g;  
		          $add=lc($add);
		          }
	               
	           	           
	          if($tpic_id =~ /STH2/i)
	              {
		          $link='http://www.theblackandwhitegalleries.com/portfolio/StephenTaylor-Haines/stephenth_colour/files/';
		          $add =~ s/^Battersea Nights Landscape C/Battersea Night Landscape C/;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
	              $add =~ s/ /-/g;
		          $add=lc($add);
		          }    
	           
 
	          if($tpic_id =~ /GG1/i)  #Georgina Goodwin
	              {
		          #$add =~ s/ /-/g;
		          $add =~ s/Half Way There Portrait BW/Half Way There Landscape BW/;
		          $add =~ s/^Maasai Dance 2 Portrait BW/Maasai Dance 2 Landscape BW/;
		          $add =~ s/^Maasai Spearman Portrait BW/Maasai Spearman Landscape BW/;
		          $add =~ s/^Mara Brothers Portrait BW/Mara Brothers Landscape BW/;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
		          $add =~ s/ /-/g;      
		          $add=lc($add);   
		          $link='http://www.theblackandwhitegalleries.com/portfolio/georginagoodwin/files/';        
	              } 
	              	           
	          if($tpic_id =~ /GG2/i)
	              {
		          $add =~ s/^Half Way There Portrait C/Half Way There Landscape C/;
		          $add =~ s/^Maasai Dance 2 Portrait C/Maasai Dance 2 Landscape C/;
		          $add =~ s/^Majesty Portrait C/majesty-portrait-c/;
		          $add =~ s/^Mara Brothers Portrait C/Mara Brothers Landscape C/;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
		          $add =~ s/ /-/g;      
		          $add=lc($add);       
		          $link='http://www.theblackandwhitegalleries.com/portfolio/georginagoodwin/georginagoodwin_colour/files/';        
	              }    
	           
 
	          if($tpic_id =~ /PJC1/i)  #PJ Clark
	              {

      	          $add =~ s/^Dappled Cat 2 Landscape BW/Dappled Cat 2 Portrait BW/;
		          $add =~ s/^Eating My Greens Landscape BW/Eating my greens Landscape C/;
		          #$add =~ s/^//;
		          #$add =~ s/^//;
		          #$add =~ s/^//;    
		              
		              
		          $add =~ s/ /-/g;    
		          $add=lc($add);    
		          $link='http://www.theblackandwhitegalleries.com/portfolio/pjclark/files/';        
	              } 
	           	           
	          if($tpic_id =~ /PJC2/i)
	              {	    
		          $add =~ s/^Come Closer Landscape 1 C/Come Closer 1 Landscape C/;
		          $add =~ s/^Come Closer Landscape 2 C/Come Closer 2 Landscape C/;
		          $add =~ s/^Come Closer Landscape 3 C/Come Closer 3 Landscape C/;
		          $add =~ s/^Crazy Horse 1 Landscape/Crazy Horse 1 Landscape C/;
		          $add =~ s/^Dappled Cat 2 Landscape C/Dappled Cat 2 Portrait C/;    
		              
		          $add =~ s/ /-/g;      
		          $add=lc($add);    
		          $link='http://www.theblackandwhitegalleries.com/portfolio/pjclark/pjclark_colour/files/';        
	              }    
	    	              	           
	           

 	          if($tpic_id =~ /MT1/i)  #Mark Tutton
	              {
		          $add =~ s/ /-/g;    
		          $link='http://www.theblackandwhitegalleries.com/portfolio/marktutton/files/';     
		          $add=lc($add);
		          } 
	           	           
	          if($tpic_id =~ /MT2/i)
	              {
		          $add =~ s/ /-/g;    
		          $link='http://www.theblackandwhitegalleries.com/portfolio/marktutton/marktutton_colour/files/';        
	              $add=lc($add);
		          }    

		          
		      if($tpic_id =~ /DS1/i)  #Dave Simpson
	              {
		          $add =~ s/ /-/g;    
		          $link='http://www.theblackandwhitegalleries.com/portfolio/davesimpson/';     
		          $add=lc($add);
		          } 
	           	           
	          if($tpic_id =~ /DS2/i)
	              {
		          $add =~ s/ /-/g;    
		          $link='http://www.theblackandwhitegalleries.com/portfolio/davesimpson/davesimpson_colour/';        
	              $add=lc($add);
		          }      
		          
		          
		          
		      if($tpic_id =~ /MS1/i)  #malcolmschuyl
	              {
		          $add =~ s/ /-/g;    
		          $link='http://www.theblackandwhitegalleries.com/portfolio/malcolmschuyl/';     
		          $add=lc($add);
		          } 
	           	           
	          if($tpic_id =~ /MS2/i)
	              {
		          $add =~ s/ /-/g;    
		          $link='http://www.theblackandwhitegalleries.com/portfolio/malcolmschuyl/malcolmschuyl_colour/';        
	              $add=lc($add);
		          } 

#http://www.theblackandwhitegalleries.com/portfolio/malcolmschuyl/index.html
#http://www.theblackandwhitegalleries.com/portfolio/malcolmschuyl/malcolmschuyl_colour/index.html
#LPMS1xxx, PPMS1xxx, LPMS2xxx and PPMS2xxx
		          
		          		          
return ($link,$add);	          	  	
	
}

sub error_messages
{
my ($html) = @_;
	
	
my $frame_landscape=0;
my $frame_portrait=0;
my $landscape_picture=0;
my $portrait_picture=0; 


my $form_count=0;

my $unassigned=0;

#my %portraits;
#% %landscapes;

my $error1='';

my $find_error_2 = '';

#my %list_of_frames;

#my $frame_count=0;


#   $html .= "Unassigned count:$unassigned<br>frame:<br>";
   
#foreach  my $first (sort keys %list_of_frames)
#   {
#   $html .= "frame count:$frame_count<br>frame: $first<br>";

#   }
   
#print $html;exit;






foreach  my $first (sort keys %form_data)
   {
   
   my ($id) = split('\|',$first);
   
   if($id =~ /FL/i){$frame_landscape++;}
   if($id =~ /FP/i){$frame_portrait++;}
   if($id =~ /^PP/i){$portrait_picture++;}
   
   my $ps = index($id,':'); 
   
   my $test_pic_id = substr($id,0,$ps);  
            
   if($test_pic_id eq '0')
       {
       if($find_error_2 ne 'yes')
          {
          $error1 .= "<font face='Arial' size='2'>Please select a matching frame for this picture.<br><br>Click on the <a style='color: rgb(255,0,0)' href='http://www.theblackandwhitegalleries.com/framesandmounts/'>Frame and Mount Selection</a><br> to choose a matching frame and size</font>." . "<br>";
          }
       $find_error_2 = 'yes';
    
       }
   
   
  
   if($id =~ /FL/i || $id =~ /FP/i)
      {   
      ### search for matching pictures for each frame
	        
      my $pos = index($id,'F');
         
      my $num_of_pics = substr($id,$pos+2,1);
      
      my $ps = index($id,':'); 
      
      my $frame_id = substr($id,0,$ps);
          
      my $pics_in_frame = 0;
	     
      foreach  my $first(sort keys %form_data)
         {
        
         my ($pic_id) = split('\|',$first);
   
         if($pic_id =~ /PP/i || $pic_id =~ /LP/i)
            {

	        my $ps = index($pic_id,':');     
            my $pic_frame_id = substr($pic_id,0,$ps);    
  
            if($frame_id eq $pic_frame_id && $pics_in_frame < $num_of_pics)    
               {
               $pics_in_frame++;    
               }
            }
         }
	  
      if($pics_in_frame < $num_of_pics)
	     {
		 my $pics_to_go = $num_of_pics - $pics_in_frame; 
		 
		 if($find_error_2 ne 'yes')
	        {
		    my $suitable2 = "Do not add landscape shaped pictures, as the frame is not designed to hold them"; 
		    my $suitable = "Do not add portrait shaped pictures, as the frame is not designed to hold them";     
		        
		    if($id =~ /FL/i)
		       {
			   $error1 .= "Please choose another " . $pics_to_go  .  " landscape shaped picture(s) for frame " . substr($id,0,1) . "<br><br>$suitable"; 
		       }
		    else
		       {
			   $error1 .= "Please choose another " . $pics_to_go  .  " portrait shaped picture(s) for frame " . substr($id,0,1) . "<br><br>$suitable2";     
		       }
		        
	        }
		 $find_error_2 = 'yes';
		 
	   #  $html .= "XXXXXXX Please choose " . $pics_to_go  .  " picture for frame" . substr($id,0,1) . "<br>"; 
	     }      
      }
   
   } 
   
            
   
   if($error1 ne '')
   
      {
      $html .= "<font color='#FF0000'>$error1</font><font face='Arial' size='3'>";
             
      $html .= "<br><br><strong><a href='http://www.theblackandwhitegalleries.com/portfolio/'>Picture Gallery</a></strong><br><br>";
              
      $html .= "<strong><a href='http://www.theblackandwhitegalleries.com/framesandmounts/'>Frame and Mount Selection</a></strong></font><br><br>";
            
            
      $html = $html . '</form></body></html>';print $html;exit;
      
      }    


}   
   
1;

