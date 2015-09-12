<?php
require FdHelperLib::getViewFilePath('head');
?>
<body>
<style type="text/css">
/*layout*/
.area_1
{
	margin:0 auto;
}
</style>
<div class="area_1">
    <form method="post" action="/add_img_process" enctype="multipart/form-data">
        <input type="file" name="file" onchange="submit()" />
    </form>
</div>
</body>
</html>
