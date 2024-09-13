<style type="text/css">
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> table.abCalendarTable{
	height: 285px !important;
	max-width: 380px !important;
}
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarMonth{
	height: 40px !important;
}
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarMonthPrev a,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarMonthNext a{
	height: 40px !important;
	max-width: 40px !important;
}
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarWeekDay,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarWeekNum,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarToday,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarReserved,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarPending,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarPast,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarEmpty,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarDate,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarPendingNightsStart,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarPendingNightsEnd,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarReservedNightsStart,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarReservedNightsEnd,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarNightsReservedReserved,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarNightsReservedPending,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarNightsPendingReserved,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarNightsPendingPending{
	height: 40px !important;
	max-width: 40px !important;
}
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarReserved,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarPending,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarPast,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarNightsReservedReserved,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarNightsReservedPending,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarNightsPendingReserved,
#pjWrapperABC_<?php echo $controller->getCalendarId(); ?> td.abCalendarNightsPendingPending{
	cursor: pointer !important;
}
</style>
<div id="calendar" class="tab-pane <?php echo $active_tab == 'calendar' ? ' active' : NULL;?>">
	<input type="hidden" name="calendar_year" id="calendar_year" value="<?php echo date('Y');?>" />
	<input type="hidden" name="calendar_month" id="calendar_month" value="<?php echo date('n');?>" />
	<div class="panel-body">
		<div class="panel-body-inner">
			<div class="row">
				<div class="col-md-4">
					<div id="pjWrapperABC_<?php echo $controller->getCalendarId(); ?>">
						<div id="abCalendar_<?php echo $controller->getCalendarId(); ?>" class="abBackendView">
						<?php include PJ_VIEWS_PATH . 'pjAdminCalendars/pjActionGetCal.php'; ?>
						</div>
					</div>
				</div>

				<div class="col-md-8">
					<div class="ibox float-e-margins">
		            	<div class="ibox-content no-margins no-padding no-top-border">
		            		<div class="m-b-sm">
		            			<?php
								if(pjAuth::factory('pjAdminReservations', 'pjActionCreate')->hasAccess())
								{
									$url = $_SERVER['PHP_SELF'].'?controller=pjAdminReservations&amp;action=pjActionCreate&amp;calendar_id='.$controller->getCalendarId();
									?>
									<a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminReservations&amp;action=pjActionCreate&amp;calendar_id=<?php echo $controller->getCalendarId(); ?>" class="btn btn-primary btn-outline btnCalAddReservation" data-url="<?php echo $url;?>"><i class="fa fa-plus"></i> <?php __('btnAddReservation'); ?></a>
									<?php
								}
								?>
							</div>
		            		<div id="calendar_grid_reservations"></div>
						</div>
					</div>
				</div>
			</div>			
		</div>
	</div>
</div>