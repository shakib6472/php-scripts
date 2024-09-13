<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAdminOwners extends pjAdmin
{
	public function pjActionCheckEmail()
	{
		$this->setAjax(true);
	
		if ($this->isXHR() && $this->isLoged())
		{
			if (!$this->_get->check('email') || $this->_get->toString('email') == '')
			{
				echo 'false';
				exit;
			}
			$pjOwnerModel = pjOwnerModel::factory();
			$pjOwnerModel->where('role_id', 3);
			$pjOwnerModel->where('t1.email', $this->_get->toString('email'));
			if ($this->isOwner())
			{
				$pjOwnerModel->where('t1.id !=', $this->getUserId());
			} elseif ($this->_get->check('id') && $this->_get->toInt('id') > 0) {
				$pjOwnerModel->where('t1.id !=', $this->_get->toInt('id'));
			}

			echo $pjOwnerModel->findCount()->getData() == 0 ? 'true' : 'false';
		}
		exit;
	}
	
	public function pjActionCreate()
	{
		$this->checkLogin();
		
		if (!pjAuth::factory()->hasAccess())
		{
			$this->sendForbidden();
			return;
		}
		
		if (self::isPost() && $this->_post->toInt('owner_create'))
		{
			$data = array();
			$data['role_id'] = 3;
			$data['status'] = $this->_post->check('status') ? 'T' : 'F';
			$data['ip'] = pjUtil::getClientIp();
			$id = pjOwnerModel::factory(array_merge($this->_post->raw(), $data))->insert()->getInsertId();
			if ($id !== false && (int) $id > 0)
			{
				$pjUserNotificationModel = pjUserNotificationModel::factory();			
				if ($this->_post->check('email_notifications') && count($this->_post->toArray('email_notifications')) > 0)	
		        {
		            $pjUserNotificationModel->reset()->begin();
		            $email_notifications_arr = $this->_post->toArray('email_notifications');
		            foreach ($email_notifications_arr as $v)
		            {
		            	list($type, $transport, $variant) = explode('_', $v);
		                $pjUserNotificationModel
		                ->reset()
		                ->set('user_id', $id)
		                ->set('type', $type)
		                ->set('variant', $variant)
		                ->set('transport', $transport)
		                ->insert();
		            }
		            $pjUserNotificationModel->commit();
		        }
		        
		        if ($this->_post->check('sms_notifications') && count($this->_post->toArray('sms_notifications')) > 0)
		        {
		            $pjUserNotificationModel->reset()->begin();
		            $sms_notifications_arr = $this->_post->toArray('sms_notifications');
		            foreach ($sms_notifications_arr as $v)
		            {
		            	list($type, $transport, $variant) = explode('_', $v);
		                $pjUserNotificationModel
		                ->reset()
		                ->set('user_id', $id)
		                ->set('type', $type)
		                ->set('variant', $variant)
		                ->set('transport', $transport)
		                ->insert();
		            }
		            $pjUserNotificationModel->commit();
		        }
			    $err = 'AOW03';
			} else {
				$err = 'AOW04';
			}
			pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminOwners&action=pjActionIndex&err=$err");
		}
		
		if (self::isGet())
		{
			$this->appendCss('bootstrap-chosen.css', PJ_THIRD_PARTY_PATH . 'chosen/');
	        $this->appendJs('chosen.jquery.js', PJ_THIRD_PARTY_PATH . 'chosen/');
			$this->appendJs('jquery.validate.min.js', PJ_THIRD_PARTY_PATH . 'validate/');
			$this->appendJs('pjAdminOwners.js');
		}
	}
	
	public function pjActionDeleteOwner()
	{
		$this->setAjax(true);
	
		if (!$this->isXHR())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		
		if (!self::isPost())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'HTTP method not allowed.'));
		}
		
		if ($this->_get->check('id') && $this->_get->toInt('id') > 0)
		{
			$pjOwnerModel = pjOwnerModel::factory();
			$arr = $pjOwnerModel->find($this->_get->toInt('id'))->getData();
			if (!empty($arr) && $pjOwnerModel->set('id', $arr['id'])->erase()->getAffectedRows() == 1)
			{
				pjUserNotificationModel::factory()->where('user_id', $arr['id'])->eraseAll();
				self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Owner have been deleted.'));
			}
			self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Owner not found.'));
		}
		self::jsonResponse(array('status' => 'ERR', 'code' => 104, 'text' => 'Missing, empty or invalid parameters.'));
	}
	
	public function pjActionDeleteOwnerBulk()
	{
		$this->setAjax(true);
	
		if (!$this->isXHR())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		
		if (!self::isPost())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'HTTP method not allowed.'));
		}
		
		$record = $this->_post->toArray('record');
		if (count($record))
		{
			$pjOwnerModel = pjOwnerModel::factory();
			$arr = pjOwnerModel::factory()->whereIn('id', $record)->findAll()->getData();
			if (!empty($arr))
			{
				$pjOwnerModel->reset()->whereIn('id', $record)->eraseAll();
				pjUserNotificationModel::factory()->whereIn('user_id', $record)->eraseAll();
				self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Owner(s) have been deleted.'));
			}
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Owner(s) not found.'));
		}
		self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing, empty or invalid parameters.'));
	}
	
	public function pjActionGetOwner()
	{
		$this->setAjax(true);
	
		if (!$this->isXHR())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		
		if (!pjAuth::factory('pjAdminOwners')->hasAccess())
		{
			$this->sendForbidden();
			return;
		}
		
		$pjOwnerModel = pjOwnerModel::factory();
		$pjOwnerModel->where('role_id', 3);
		if ($q = $this->_get->toString('q'))
		{
			$q = str_replace(array('%', '_'), array('\%', '\_'), trim($q));
			$pjOwnerModel->where(sprintf("t1.name LIKE '%1\$s' OR t1.email LIKE '%1\$s' OR t1.phone LIKE '%1\$s'", "%$q%"));
		}
		if (in_array($this->_get->toString('status'), array('T', 'F')))
		{
		    $pjOwnerModel->where('t1.status', $this->_get->toString('status'));
		}
		$column = 'name';
		$direction = 'ASC';
		if ($this->_get->toString('column') && in_array(strtoupper($this->_get->toString('direction')), array('ASC', 'DESC')))
		{
			$column = $this->_get->toString('column');
			$direction = strtoupper($this->_get->toString('direction'));
		}
		
		$total = $pjOwnerModel->findCount()->getData();
		$rowCount = $this->_get->toInt('rowCount') ? $this->_get->toInt('rowCount') : 10;
		$pages = ceil($total / $rowCount);
		$page = $this->_get->toInt('page') ? $this->_get->toInt('page') : 1;
		$offset = ((int) $page - 1) * $rowCount;
		if ($page > $pages)
		{
			$page = $pages;
		}

		$data = $pjOwnerModel
		->select('t1.id, t1.email, t1.name, DATE(t1.created) AS `created`, DATE(t1.last_login) AS `last_login`, t1.status, t1.is_active, t1.locked, t1.role_id')
		->orderBy("$column $direction")
		->limit($rowCount, $offset)
		->findAll()
		->getData();
		
		foreach($data as $k => $v) 
		{
		    $data[$k]['name'] = pjSanitize::clean($v['name']);
		    $data[$k]['email'] = pjSanitize::clean($v['email']);
		}

		self::jsonResponse(compact('data', 'total', 'pages', 'page', 'rowCount', 'column', 'direction'));
	}
	
	public function pjActionIndex()
	{
		$this->checkLogin();
		
		if (!pjAuth::factory('pjAdminOwners')->hasAccess())
		{
			$this->sendForbidden();
			return;
		}
		
		$this->appendJs('jquery.datagrid.js', PJ_FRAMEWORK_LIBS_PATH . 'pj/js/');
		$this->appendJs('pjAdminOwners.js');
	}
	
	public function pjActionSaveOwner()
	{
		$this->setAjax(true);
	
		if (!$this->isXHR())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		if (!self::isPost())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'HTTP method not allowed.'));
		}
		if (!pjAuth::factory('pjAdminOwners', 'pjActionUpdate')->hasAccess())
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Access denied.'));
		}
		
		$params = array(
				'id' => $this->_get->toInt('id'),
				'column' => $this->_post->toString('column'),
				'value' => $this->_post->toString('value'),
		);
		if (!(isset($params['id'], $params['column'], $params['value'])
				&& pjValidation::pjActionNumeric($params['id'])
				&& pjValidation::pjActionNotEmpty($params['column'])))
		{
			self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Missing, empty or invalid parameters.'));
		}
		
		$pjOwnerModel = pjOwnerModel::factory();
		$pjOwnerModel->set('id', $params['id'])->modify(array($params['column'] => $params['value']));
		
		self::jsonResponse(array('status' => 'OK', 'code' => 200));
	}
	
	public function pjActionUpdate()
	{
		$this->checkLogin();
		
		if (!pjAuth::factory()->hasAccess())
		{
			$this->sendForbidden();
			return;
		}
			
		if (self::isPost() && $this->_post->toInt('owner_update'))
		{
			$data = array();
			$data['role_id'] = 3;
			$data['status'] = $this->_post->check('status') ? 'T' : 'F';
			$data = array_merge($this->_post->raw(), $data);
			if ($this->_post->isEmpty('password')) {
				unset($data['password']);
			}
			pjOwnerModel::factory()->set('id', $this->_post->toInt('id'))->modify($data);

			$pjUserNotificationModel = pjUserNotificationModel::factory();
			$pjUserNotificationModel->where('user_id', $this->_post->toInt('id'))->eraseAll();
			
			if ($this->_post->check('email_notifications') && count($this->_post->toArray('email_notifications')) > 0)
	        {
	            $pjUserNotificationModel->reset()->begin();
	            $email_notifications_arr = $this->_post->toArray('email_notifications');
	            foreach ($email_notifications_arr as $v)
	            {
	            	list($type, $transport, $variant) = explode('_', $v);
	                $pjUserNotificationModel
	                ->reset()
	                ->set('user_id', $this->_post->toInt('id'))
	                ->set('type', $type)
	                ->set('variant', $variant)
	                ->set('transport', $transport)
	                ->insert();
	            }
	            $pjUserNotificationModel->commit();
	        }
	        
	        if ($this->_post->check('sms_notifications') && count($this->_post->toArray('sms_notifications')) > 0)
	        {
	            $pjUserNotificationModel->reset()->begin();
	            $sms_notifications_arr = $this->_post->toArray('sms_notifications');
	            foreach ($sms_notifications_arr as $v)
	            {
	            	list($type, $transport, $variant) = explode('_', $v);
	                $pjUserNotificationModel
	                ->reset()
	                ->set('user_id', $this->_post->toInt('id'))
	                ->set('type', $type)
	                ->set('variant', $variant)
	                ->set('transport', $transport)
	                ->insert();
	            }
	            $pjUserNotificationModel->commit();
	        }
			
			pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminOwners&action=pjActionIndex&err=AOW01");
		} 
		
		if (self::isGet())
		{
			$arr = pjOwnerModel::factory()->find($this->_get->toInt('id'))->getData();
			if (count($arr) === 0)
			{
				pjUtil::redirect(PJ_INSTALL_URL. "index.php?controller=pjAdminOwners&action=pjActionIndex&err=AOW08");
			}
			$this->set('arr', $arr);
			
			$user_notification_arr = array();
			$user_notifications = pjUserNotificationModel::factory()->where('t1.user_id', $arr['id'])->findAll()->getData();
			foreach ($user_notifications as $val) {
				$user_notification_arr[] = $val['type'].'_'.$val['transport'].'_'.$val['variant'];
			}
			$this->set('user_notification_arr', $user_notification_arr);
			
			$this->appendCss('bootstrap-chosen.css', PJ_THIRD_PARTY_PATH . 'chosen/');
	        $this->appendJs('chosen.jquery.js', PJ_THIRD_PARTY_PATH . 'chosen/');
			$this->appendJs('jquery.validate.min.js', PJ_THIRD_PARTY_PATH . 'validate/');
			$this->appendJs('pjAdminOwners.js');
		}
	}
}
?>