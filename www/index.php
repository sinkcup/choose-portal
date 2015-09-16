<?php
require dirname(__FILE__).'/../lib/auto_load.php';
$written_language_tag = UserLib::getWrittenLanguageTag();
$uri = $_SERVER['REQUEST_URI'];
function encodeFilterUri($uri_data, $where=array())
{
    $map = ConfigParserLib::get('category', 'category_map');
    $uri_position = ConfigParserLib::get('product/' . $uri_data['category_name'], 'uri_position');
    $where_uri = implode('-', array_values($where));
    if(empty($where) || 0 < preg_match('/^1-1-(00\-)+00$/', $where_uri))
    {
        $where_uri = '';
    }
    return '/' . $uri_data['group_name'] . '/' . array_search($uri_data['category_name'], $map) . '/' . $where_uri;
}
//首页
if(0 < preg_match('/^\/$/', $uri))
{
    require dirname(__FILE__).'/../module/all_groups.php';
    require FdHelperLib::getViewFilePath('index');
    exit;
}
//某个类别的筛选 /phone/cell_phones/0-0
if((0 < preg_match('/^\/\w+\/\w+\/[0-9\.-]+$/', $uri)) || (0 < preg_match('/^\/\w+\/\w+\/$/', $uri)))
{
    $page_tmp_dir = ConfigParserLib::get('tmp', 'tmp_dir') . md5($_SERVER['REQUEST_URI']) . '/';
    $ttl = ConfigParserLib::get('tmp', 'page_tmp_ttl');
    //header('Cache-Control: max-age=' . $ttl * 60);
    header('Cache-Control: max-age=180');
    $now = time();
    //$filename = strtotime(date('Y-m-d H', $now) . ':00:00') + intval(date('i', $now) / $ttl) * $ttl * 60;
    $filename = strtotime(date('Y-m-d H', $now) . ':00:00');
    $tmp_file_path = $page_tmp_dir . $filename;
    $page = @file_get_contents($tmp_file_path);
    if(!empty($page))
    {
        echo $page;
        exit;
    }
    if(!file_exists($page_tmp_dir))
    {
        mkdir($page_tmp_dir, 0777, true);
    }
    else
    {
        $dh = opendir($page_tmp_dir);
        while ($file = readdir($dh))
        {
            if($file!='.' && $file!='..')
            {
                $path = $page_tmp_dir . '/' . $file;
                if(!is_dir($path))
                {
                  unlink($path);
                }
            }
        }
        closedir($dh);
    }
    ob_start();
    $tmp = explode('/',$uri);
    $map = ConfigParserLib::get('category', 'category_map');
    $uri_data = array
    (
        'group_name' => $tmp[1],
        'category_name' => $map[$tmp[2]],
        'where' => $tmp[3],
    );
    $v['uri_data'] = $uri_data;
    unset($tmp);
    header('Cache-Control: public, max-age=180');
    header('Content-Type:text/html; charset=UTF-8');
    $output = array();
    require dirname(__FILE__).'/../module/head.php';
    require dirname(__FILE__).'/../module/logo_and_search.php';
    //require dirname(__FILE__).'/../module/group_hidden_categories_nav.php';
    require dirname(__FILE__).'/../module/group_open_categories_nav.php';
    require dirname(__FILE__).'/../module/filter.php';
    require dirname(__FILE__).'/../module/order_by.php';
    require dirname(__FILE__).'/../module/products_preview.php';
    require FdHelperLib::getViewFilePath('list/index');
    $page = ob_get_contents();
    //file_put_contents($tmp_file_path, $page);
    ob_flush();
    exit;
}
//添加商品
if(0 < preg_match('/^\/\w+\/add$/', $uri))
{
    $tmp = explode('/',$uri);
    $map = ConfigParserLib::get('category', 'category_map');
    $uri_data = array
    (
	'category_name' => $map[$tmp[1]],
    );
    $v['uri_data'] = $uri_data;
    unset($tmp);
    header('Content-Type:text/html; charset=UTF-8');
    $output = array();
    require dirname(__FILE__).'/../module/head.php';
    require dirname(__FILE__).'/../module/logo_and_search.php';
    //require dirname(__FILE__).'/../module/group_hidden_categories_nav.php';
    require dirname(__FILE__).'/../module/add_product.php';
    require FdHelperLib::getViewFilePath('list/add');
    exit;
}
//添加商品处理
if(0 < preg_match('/^\/\w+\/add_process$/', $uri))
{
    var_dump($_POST);
    $data = $_POST;
    foreach($data as $key=>$value)
    {
        if(is_array($value))
        {
            $data[$key] = json_encode($value);
        }
    }
    $params = array
    (
        'post' => $data
    );
    $tmp = explode('/',$uri);
    $map = ConfigParserLib::get('category', 'category_map');
    $uri_data = array
    (
	    'category_name' => $map[$tmp[1]],
    );
    $r = FdHelperLib::crudApi('products/' . array_search($uri_data['category_name'], $map), $written_language_tag, $params);
    var_dump($r);
    exit;
}
//添加图片
if(0 < preg_match('/^\/add_img$/', $uri))
{
    $output = array();
    //require dirname(__FILE__).'/../module/group_hidden_categories_nav.php';
    require FdHelperLib::getViewFilePath('add_img');
    exit;
}
//添加图片处理
if(0 < preg_match('/^\/add_img_process$/', $uri))
{
    $tmp = explode('.',$_FILES['file']['name']);
    $last = count($tmp) -1;
    $ext = strtolower($tmp[$last]); //后缀名用小写
    if(!in_array($ext, array('jpg', 'png')))
    {
        exit;
    }
    $new_file_path = $_FILES['file']['tmp_name'] . '.' . $ext;
    move_uploaded_file($_FILES["file"]["tmp_name"], $new_file_path);
    $params = array
    (
        'post' => array
        (
            'file' => '@' . $new_file_path
        )
    );
    $tmp = FdHelperLib::crudApi('qiniu/auth', $written_language_tag, array('post'=>array('nothing'=>1)));
    $token = $tmp['token'];

    // 要上传文件的本地路径
    $filePath = $new_file_path;

    // 上传到七牛后保存的文件名
    $newFilename = md5($new_file_path) . '.' . $ext;
    $key = 'shaixuan/' . $newFilename;

    // 初始化 UploadManager 对象并进行文件的上传。
    $uploadMgr = new Qiniu\Storage\UploadManager();
    list($ret, $err) = $uploadMgr->putFile($token, $key, $filePath);

    $v['title'] = '';
    $v['img_filename'] = $newFilename;
    $v['img_server'] = ConfigParserLib::get('fd', 'img_server');
    $v['product_preview_img_width'] = ConfigParserLib::get('fd', 'product_preview_img_width');
    $v['product_preview_img_height'] = ConfigParserLib::get('fd', 'product_preview_img_height');
    $v['img_quality'] = ConfigParserLib::get('fd', 'img_quality');
    require FdHelperLib::getViewFilePath('add_img_process');
    exit;
}
//查看一个商品
if(0 < preg_match('/^\/\w+\/[0-9]+$/', $uri))
{
    $page_tmp_dir = ConfigParserLib::get('tmp', 'tmp_dir') . md5($_SERVER['REQUEST_URI']) . '/';
    $ttl = ConfigParserLib::get('tmp', 'page_tmp_ttl');
    //header('Cache-Control: max-age=' . $ttl * 60);
    header('Cache-Control: public, max-age=180');
    $now = time();
    //$filename = strtotime(date('Y-m-d H', $now) . ':00:00') + intval(date('i', $now) / $ttl) * $ttl * 60;
    $filename = strtotime(date('Y-m-d H', $now) . ':00:00');
    $tmp_file_path = $page_tmp_dir . $filename;
    $page = @file_get_contents($tmp_file_path);
    if(!empty($page))
    {
        echo $page;
        exit;
    }
    if(!file_exists($page_tmp_dir))
    {
        mkdir($page_tmp_dir, 0777, true);
    }
    else
    {
        $dh = opendir($page_tmp_dir);
        while ($file = readdir($dh))
        {
            if($file!='.' && $file!='..')
            {
                $path = $page_tmp_dir . '/' . $file;
                if(!is_dir($path))
                {
                  unlink($path);
                }
            }
        }
        closedir($dh);
    }
    ob_start();
    $tmp = explode('/',$uri);
    $map = ConfigParserLib::get('category', 'category_map');
    $uri_data = array
    (
	'category_name' => $map[$tmp[1]],
        'id' => $tmp[2],
    );
    $v['uri_data'] = $uri_data;
    unset($tmp);
    header('Content-Type:text/html; charset=UTF-8');
    $output = array();
    require dirname(__FILE__).'/../module/head.php';
    require dirname(__FILE__).'/../module/logo_and_search.php';
    require dirname(__FILE__).'/../module/show_product.php';
    require FdHelperLib::getViewFilePath('product/show');
    $page = ob_get_contents();
    //file_put_contents($tmp_file_path, $page);
    ob_flush();
    exit;
}
//修改（等待输入）
if(0 < preg_match('/^\/\w+\/[0-9]+\/edit$/', $uri))
{
    $tmp = explode('/',$uri);
    $map = ConfigParserLib::get('category', 'category_map');
    $uri_data = array
    (
	'category_name' => $map[$tmp[1]],
        'id' => $tmp[2],
    );
    $v['uri_data'] = $uri_data;
    unset($tmp);
    header('Content-Type:text/html; charset=UTF-8');
    $output = array();
    require dirname(__FILE__).'/../module/head.php';
    require dirname(__FILE__).'/../module/logo_and_search.php';
    //require dirname(__FILE__).'/../module/group_hidden_categories_nav.php';
    require dirname(__FILE__).'/../module/edit_product.php';
    require FdHelperLib::getViewFilePath('product/edit');
    exit;
}
//修改保存。todo，也许应该为edit_process
if(0 < preg_match('/^\/\w+\/[0-9]+\/save$/', $uri))
{
    var_dump($_POST);
    $data = $_POST;
    foreach($data as $key=>$value)
    {
        if(is_array($value))
        {
            $data[$key] = json_encode($value);
        }
    }
    $params = array
    (
        'put' => $data
    );
    $tmp = explode('/',$uri);
    $map = ConfigParserLib::get('category', 'category_map');
    $uri_data = array
    (
	'category_name' => $map[$tmp[1]],
        'id' => $tmp[2],
    );
    $r = FdHelperLib::crudApi('products/' . array_search($uri_data['category_name'], $map) . '/' . $uri_data['id'], $written_language_tag, $params);
    var_dump($r);
    exit;
}

header("HTTP/1.1 404 Not Found");
header("Status: 404 Not Found");
?>
