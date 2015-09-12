<?php
class FdHelperLib
{
    public static $using_template_name;
    
    public static function crudHttp($uri, $data, $header=array())
    {
        $ch = curl_init();
        if(isset($data['get'])&&!empty($data['get']))
        {
            $uri .= '?' . http_build_query($data['get']);
        }
        if(isset($data['post'])&&!empty($data['post']))
        {
            curl_setopt($ch, CURLOPT_POST, true);
            curl_setopt($ch, CURLOPT_POSTFIELDS, $data['post']);
        }
        if(isset($data['put'])&&!empty($data['put']))
        {
            $str = stripslashes(http_build_query($data['put']));
            $tmp_file = tmpfile();
            fwrite($tmp_file, $str);
            fseek($tmp_file, 0);

            curl_setopt($ch, CURLOPT_PUT, true);
            curl_setopt($ch, CURLOPT_INFILE, $tmp_file);
            curl_setopt($ch, CURLOPT_INFILESIZE, strlen($str));
        }
        if(isset($data['delete'])&&!empty($data['delete']))
        {
            curl_setopt($ch, CURLOPT_CUSTOMREQUEST, 'DELETE');
            curl_setopt($ch, CURLOPT_POSTFIELDS, $data['delete']);
        }
        curl_setopt($ch, CURLOPT_URL, $uri);
        curl_setopt($ch, CURLOPT_HEADER, false);
        curl_setopt($ch, CURLOPT_HTTPHEADER, $header);
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
        $r = curl_exec($ch);
        curl_close($ch);
        return $r;
    }
    
    public static function getUsingTempleteName()
    {
        if(!empty(self::$using_template_name))
        {
            return self::$using_template_name;
        }
        $t = ConfigParserLib::get('fd','default_template_name');
        self::$using_template_name = $t;
        return $t;
    }
    
    public static function getViewFilePath($filename)
    {
        return ConfigParserLib::get('fd','templates_path') . self::getUsingTempleteName(). '/' . $filename .'.tpl';
    }
    
    public static function getModuleFilePath($filename)
    {
        return ConfigParserLib::get('fd','module_path') . $filename .'.php';
    }
    
    public static function crudApi($api_name, $written_language_tag, $params=array())
    {
        $header = array
        (
            'Accept: ' . ConfigParserLib::get('fd','api_format') . '; version=' .  ConfigParserLib::get('fd','api_version'),
            'Accept-Language: ' . $written_language_tag
        );
        $uri = ConfigParserLib::get('fd','api_uri') . $api_name;
        $tmp = self::crudHttp($uri, $params, $header);
        $r = json_decode($tmp, true);
        if(isset($r['result']))
        {
            return $r['result']['data'];
        }
        return array();
    }

    public static function crudImgApi($api_name, $params=array())
    {
        $img_api = ConfigParserLib::get('fd','img_api');
        $header = array
        (
            'Accept: ' . $img_api['format'] . '; version=' .  $img_api['version'],
        );
        $uri = $img_api['uri'] . $api_name;
        $tmp = self::crudHttp($uri, $params, $header);
        $r = json_decode($tmp, true);
        if(isset($r['result']))
        {
            return $r['result']['data'];
        }
        return array();
    }
    
    public static function getImgUri($filename, $width, $height)
    {
        $tmp = explode('.', $filename);
        $server_count = ConfigParserLib::get('fd', 'img_server[\'count\']');
        $server_num = (ord(substr($tmp[0], -1)) % $server_count) + 1;
        $servers_uri = ConfigParserLib::get('fd', 'img_server[\'uri\']');
        $uri = $servers_uri[$server_num] . $filename . '?imageView2/0/q/' . ConfigParserLib::get('fd', 'img_quality');
        if ($width != 'auto') {
            $uri .= '/w/' . $width;
        }
        if ($height != 'auto') {
            $uri .= '/h/' . $height;
        }
        return $uri;
    }

    public static function getProductUri($category_name, $id)
    {
        $map = ConfigParserLib::get('category', 'category_map');
        return '/' . array_search($category_name, $map) . '/' . $id;
    }
}
?>
