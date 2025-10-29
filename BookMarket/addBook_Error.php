<!doctype html>
<html class="h-100" >   
  <title>도서 등록</title>
  <link href="./resources/css/bootstrap.min.css" rel="stylesheet">    
    
  <style type="text/css">
        .error{ color: red; }
        .required{ color: red; }
        .success{ color: green; }
    </style>
    <!-- Custom styles for this template -->
</head>
  <body class="d-flex flex-column h-100">
  <?php      
    require "./menu.php";
  ?>
<br>
 <main>
 <div class="container py-5">
   <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">도서 등록</h1>
            <p class="col-md-8 fs-4">Book Addition</p>
        </div>
   </div>
   <div class="row align-items-md-stretch">      
        <div class="col-md-12">
            <div class="h-100 p-5">
            <form name="newBook" action="./processAddBook.php" method ="post" enctype ="multipart/form-data">		      	
                <div class="mb-3 row">
                    <label class="col-sm-2">도서코드<sup class="required">*</sup></label>
                    <div class="col-sm-3">
                        <input type="text" name="bookId" value="<?php echo $bookId; ?>" class="form-control" >              
                    </div>
                    <div class="col-sm-6">
                    <span class="error"><?php echo $bookIdErr; ?></span>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-2">도서명<sup class="required">*</sup></label>
                    <div class="col-sm-3">
                        <input type="text" name="name" value="<?php echo $name; ?>" class="form-control" >
                    </div>
                    <div class="col-sm-6">
                    <span class="error"><?php echo $nameErr; ?></span>
                    </div>
                </div>
                    <div class="mb-3 row">
                    <label class="col-sm-2">가격<sup class="required">*</sup></label>
                    <div class="col-sm-3">
                        <input type="text" name="unitPrice" value="<?php echo $unitPrice; ?>" class="form-control" >
                    </div>
                    <div class="col-sm-6">
                    <span class="error"><?php echo $unitPriceErr; ?></span>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-2">저자</label>
                    <div class="col-sm-3">
                        <input type="text" name="author" value="<?php echo $author; ?>" class="form-control">
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-2">상세정보<sup class="required">*</sup></label>
                    <div class="col-sm-5">
                        <textarea name="description" cols="50" rows="2"
                            class="form-control" placeholder="100자 이상 적어주세요"><?php echo $description; ?></textarea> <span class="error"><?php echo $descriptionErr; ?></span>
                    </div>
                    
                </div>       
                <div class="mb-3 row">
                    <label class="col-sm-2">분류</label>
                    <div class="col-sm-3">
                        <input type="text" name="category" value="<?php echo $category; ?>" class="form-control" >
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-2">재고수<sup class="required">*</sup></label>
                    <div class="col-sm-3">
                        <input type="text" name="unitsInStock" value="<?php echo $unitsInStock; ?>" class="form-control" >
                    </div>
                    <div class="col-sm-6">
                    <span class="error"><?php echo $unitsInStockErr; ?></span>
                    </div>
                </div>
                <div class="mb-3 row">
                    <label class="col-sm-2">출판일</label>
                    <div class="col-sm-3">
                        <input type="text" name="releaseDate" value="<?php echo $releaseDate; ?>" class="form-control">
                    </div>
                </div>        
                <div class="mb-3 row">
                    <label class="col-sm-2">상태</label>
                    <div class="col-sm-5">
                        <input type="radio" name="condition" value="New " checked> 신규도서 
                        <input type="radio" name="condition" value="Old" > 중고도서 
                        <input type="radio" name="condition" value="EBook" > E-Book
                    </div>				
                </div>	
                <div class="mb-3 row">
                    <label class = "col-sm-2">이미지<sup class="required">*</sup></label>
                    <div class ="col-sm-5">
                        <input type="file" name="bookImage" class="form-control"><span class="error"><?php echo $bookImageErr; ?></span>
                    </div>
                </div>	
                <div class="mb-3 row">
                    <div class="col-sm-offset-2 col-sm-10 ">
                        <input type="submit" class="btn btn-primary" name="submit" value="등록" >
                        <input type="reset" class="btn btn-secondary" name="reset" value="취소" >
                    </div>
                </div>
            </form>
            </div>         
        </div>
    </div>
</div>
</main>
<?php     
    require "./footer.php";

?>
</body>
</html>


