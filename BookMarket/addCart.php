<?php
    
	$bookId = $_GET["id"];
	if ($bookId == null || $bookId=="") {
		header("Location:books.php");
		return;
	}
    require "./model.php";  
	
	$book = getBookById($bookId);
	
	if ($book == null) {
		header("Location:exceptionNoBookId.php");
	}
    
	
	session_start();	
	if(isset($_SESSION["cartlist"])){
		$count = count($_SESSION["cartlist"]);
		$goodsList = $_SESSION["cartlist"];

		$cnt = 0;
		$goodsQnt="";
		for ($i = 0; $i < $count; $i++) {	
			$goodsid = key($goodsList);
			$goods = $goodsList[$goodsid];
			if ($goodsid==$bookId) { 
				$cnt++;
				$goods["quantity"] = $goods["quantity"] + 1;
				$_SESSION["cartlist"][$bookId] =$goods;

				break;
			}   			 
			next($goodsList);   			
		}

		if ($cnt == 0) { 			
			$goods =  getBookById($bookId);
			$goods["quantity"]=1;
			$_SESSION["cartlist"][$bookId] =$goods;
		
		}
	}
	else{
		$book = getBookById($bookId);
		$book["quantity"] = 1;
		$_SESSION["cartlist"][$bookId] = $book;
	}
	
	header("Location:book.php?id=".$bookId);  
?>