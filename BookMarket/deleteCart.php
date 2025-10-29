<?php
	
    session_start();
	$cartId = $_GET["cartId"];

    if ($cartId == null || $cartId=="") {
        header("Location:cart.php");
	
		return;
	}

    //$goodsList = $_SESSION["cartlist"];
	//session_unset();
    session_destroy();     
    header("Location:cart.php");
?>
