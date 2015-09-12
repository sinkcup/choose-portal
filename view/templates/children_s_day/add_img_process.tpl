<?php
require FdHelperLib::getViewFilePath('head');
?>
<body>
<style type="text/css">
</style>
<script type="text/javascript">
    var div = document.createElement('div');
    var img = document.createElement('img');
    var img_server_uri = '<?php echo $v['img_server']['uri']['1'];?>';
    var img_quality = '<?php echo $v['img_quality'];?>';
    var product_preview_img_width = '<?php echo $v['product_preview_img_width'];?>';
    var product_preview_img_height = '<?php echo $v['product_preview_img_height'];?>';

    var img_filename = '<?php echo $v['img_filename'];?>';
    var tmp = img_filename.split('.');
    img.src = img_server_uri + tmp[0] + '-' + img_quality + '-' + product_preview_img_width + 'x' + product_preview_img_height + '.' + tmp[1];
    img.width = product_preview_img_width;
    img.height = product_preview_img_height;
    var iframe = self;
    img.onload = function()
    {
        iframe.window.location.href = '/add_img';
    };
    var input = document.createElement('input');
    input.type = 'text';
    input.value = img_filename;
    input.name = 'preview_img[]';
    var a = document.createElement('a');
    a.href = '#';
    a.onclick = function ()
    {
        this.parentNode.parentNode.removeChild(this.parentNode);
        return false;
    }
    var t = document.createTextNode('删除');
    a.appendChild(t);
    div.appendChild(img);
    div.appendChild(input);
    div.appendChild(a);
    window.parent.document.getElementById('preview_img').appendChild(div);
    //window.location.href = './add_img';
    //self.history.back();
</script>
</body>
</html>
