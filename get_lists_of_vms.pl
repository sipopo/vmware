#!/usr/bin/perl -w

#
#   --server 
#
 
use strict;
use warnings;
use VMware::VILib;
use VMware::VIRuntime;

 
# validate options, and connect to the server
Opts::parse();
Opts::validate();
Util::connect();

open (file,">>vm_list_clusters_power_on");

my $clusters = Vim::find_entity_views(view_type => 'ClusterComputeResource', properties => ['name']);
foreach(@$clusters) {
        #print "\t" . $_->{'name'} . "\n";
	my $cluster_name = $_->{'name'};

	my $esxi = Vim::find_entity_views(view_type => 'VirtualMachine', 
				begin_entity => $_ ,
				filter => { 'runtime.powerState' => 'poweredOn' },
				properties => ['name']);
	foreach (@$esxi) {
		print "$cluster_name \t" . $_->{'name'} . "\n";	
		print file "$cluster_name \t" . $_->{'name'} . "\n"; 
	}

}

close(file);



#my $vmhosts = Vim::find_entity_views(view_type => 'HostSystem', properties => ['name']);
 
#print "ESX(i) hosts residing on " . Opts::get_option('server') . "\n";

#open (hosts,">>esx_lists");
#foreach(@$vmhosts) {
#        print "\t" . $_->{'name'} . "\n";
#	print hosts "VMWARE.FTTB " . $_->{'name'} . "\n";
#}
#close(hosts);
 
Util::disconnect();
