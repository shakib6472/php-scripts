<?php
$is_test_mode = (int) $tpl['arr']['is_test_mode'] === 1;
?>
<form action="https://www.2checkout.com/checkout/purchase" method="post" style="display: inline" name="<?php echo $tpl['arr']['name']; ?>" id="<?php echo $tpl['arr']['id']; ?>" target="<?php echo $tpl['arr']['target']; ?>">
	<?php
	if ($is_test_mode)
	{
		?><input type="hidden" name="demo" value="Y"><?php
	}
	?>
    <input type="hidden" name="sid" value="<?php echo $tpl['arr']['merchant_id']; ?>">
	<input type="hidden" name="mode" value="2CO">
    <input type="hidden" name="li_0_type" value="product" />
    <input type="hidden" name="li_0_name" value="<?php echo $tpl['arr']['custom']; ?>" />
	<input type="hidden" name="li_0_quantity" value="1" />
	<input type="hidden" name="li_0_price" value="<?php echo $tpl['arr']['amount']; ?>" />
	<input type="hidden" name="li_0_tangible" value="N" />
	<input type="hidden" name="li_0_product_id" value="<?php echo $tpl['arr']['custom']; ?>" />
	<input type="hidden" name="li_0_description" value="<?php echo $tpl['arr']['custom']; ?>" />
    <input type="hidden" name="li_0_recurrence" value="<?php echo $tpl['arr']['recurrence']; ?>" />
	<input type="hidden" name="li_0_duration" value="<?php echo $tpl['arr']['duration']; ?>" />
    <input type="hidden" name="card_holder_name" value="<?php echo $tpl['arr']['first_name'] . ' ' . $tpl['arr']['last_name']; ?>">
    <input type="hidden" name="email" value="<?php echo $tpl['arr']['email']; ?>">
    <input type="hidden" name="phone" value="<?php echo $tpl['arr']['phone']; ?>">
	<input type="hidden" name="currency_code" value="<?php echo $tpl['arr']['currency_code']; ?>">
    <input type="hidden" name="x_receipt_link_url" value="<?php echo $tpl['arr']['notify_url']; ?>">
    <input type="hidden" name="lang" value="<?php echo $tpl['arr']['locale']; ?>">
</form>