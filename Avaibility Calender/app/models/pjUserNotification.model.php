<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjUserNotificationModel extends pjAppModel
{
	protected $primaryKey = 'id';
	
	protected $table = 'users_notifications';
	
	protected $schema = array(
		array('name' => 'id', 'type' => 'int', 'default' => ':NULL'),
	    array('name' => 'user_id', 'type' => 'int', 'default' => ':NULL'),
		array('name' => 'type', 'type' => 'enum', 'default' => 'mycal'),
		array('name' => 'variant', 'type' => 'varchar', 'default' => ':NULL'),
		array('name' => 'transport', 'type' => 'enum', 'default' => ':NULL')
	);
	
	protected $validate = array();
		
	public static function factory($attr=array())
	{
		return new self($attr);
	}
	
}
?>