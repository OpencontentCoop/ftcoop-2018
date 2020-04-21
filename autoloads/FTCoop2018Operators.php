<?php

class FTCoop2018Operators
{

    private static $contextData;

    private static $operators = array(
        'ftcoop_pagedata' => array(),
        'ftcoop_incarici_persona' => array(
            'persona' => array('type' => 'object', 'required' => true)
        ),
        'ftcoop_opengraph' => array(
            'node' => array('type' => 'object', 'required' => true)
        ),
    );

    function operatorList()
    {
        return array_keys(self::$operators);
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return self::$operators;
    }

    function modify(
        eZTemplate $tpl,
        $operatorName,
        $operatorParameters,
        $rootNamespace,
        $currentNamespace,
        &$operatorValue,
        $namedParameters
    ) {
        switch ($operatorName) {

            case 'ftcoop_opengraph':
                $operatorValue = $this->loadOpenGraphData($namedParameters['node']);
                break;

            case 'ftcoop_incarici_persona':
                $persona = $namedParameters['persona'];                
                $data = array();
                if($persona instanceof eZContentObject){
                    $ftcoopIni = eZINI::instance('ftcoop.ini');
                    $hiddenTypes = array();
                    if ($ftcoopIni->hasVariable('RuoliSettings', 'NascondiTipologiaId')){
                        $hiddenTypes = (array)$ftcoopIni->variable('RuoliSettings', 'NascondiTipologiaId');
                    }
                    $oggettiRilevantiFederazione = $ftcoopIni->variable('OggettiRilevanti', 'Federazione');
                    $rolesData = eZContentFunctionCollection::fetchReverseRelatedObjects( 
                        $persona->attribute('id'), 
                        'ruolo/persona', 
                        false, false, 
                        array('published', 'asc'), false
                    );
                    if (isset($rolesData['result'])){
                        foreach ($rolesData['result'] as $index => $role) {
                            $dataMap = $role->dataMap();
                            $tipologiaIdList = array();
                            $societaIdList = array();
                            $nomina = $dataMap['nomina']->toString() + $index;
                            if (isset($dataMap['tipologia_di_ruolo']) && $dataMap['tipologia_di_ruolo']->hasContent()){
                                $tipologiaIdList = explode('-', $dataMap['tipologia_di_ruolo']->toString());
                            }
                            if (isset($dataMap['societa']) && $dataMap['societa']->hasContent()){
                                $societaIdList = explode('-', $dataMap['societa']->toString());                                
                            }
                            $intersect = array_intersect($hiddenTypes, $tipologiaIdList);                            
                            if (empty($intersect) && $role->canRead() && !in_array($oggettiRilevantiFederazione, $societaIdList)){
                                $data[$nomina] = $role;
                            }
                        }
                        ksort($data);
                    }
                }
                $operatorValue = $data;
            break;

            case 'ftcoop_pagedata':

                if (self::$contextData === null) {

                    $data = array(
                        'require_container' => true,
                        'subsite_id' => 0,
                        'topmenu_template_uri' => false,
                        'is_homepage' => false,
                        'reverse_path_id_array' => array(),
                        'path_array' => array(),
                        'has_subheader' => false,
                        'show_breadcrumb' => true,
                        'show_login' => false,
                        'canonical_language_url' => false,
                        'canonical_url' => false,
                        'global_root_node' => (int)eZINI::instance('site.ini')->variable('SiteSettings', 'GlobalSiteRootNodeID'),
                        'root_node' => (int)eZINI::instance('content.ini')->variable('NodeSettings', 'RootNode'),
                        'is_global_root' => false,
                        'has_breadcrumb' => false,
                    );

                    $currentModuleParams = $GLOBALS['eZRequestedModuleParams'];
                    $request = array(
                        'module' => $currentModuleParams['module_name'],
                        'function' => $currentModuleParams['function_name'],
                        'parameters' => $currentModuleParams['parameters'],
                    );
                    $data['is_login_page'] = $request['module'] == 'user' && $request['function'] == 'login';
                    $data['is_register_page'] = $request['module'] == 'user' && $request['function'] == 'register';
                    $data['is_search_page'] = $request['module'] == 'content' && ( $request['function'] == 'search' || $request['function'] == 'advancedsearch' );
                    $data['is_edit'] = $request['module'] == 'content' && $request['function'] == 'edit';
                    $data['is_browse'] = $request['module'] == 'content' && $request['function'] == 'browse';
                    $data['is_view'] = !$data['is_edit'] && !$data['is_browse'];

                    if ($tpl->hasVariable('module_result')) {
                        $moduleResult = $tpl->variable('module_result');

                        $data['ui_context'] = $moduleResult['ui_context'];

                        $path = ( isset($moduleResult['path']) && is_array($moduleResult['path']) ) ? $moduleResult['path'] : array();
                        $reversePath = array_reverse($path);
                        $subSiteNodeIdList = self::getSubSiteNodeList();
                        foreach ($reversePath as $key => $item) {
                            if (isset($item['node_id'])) {
                                $data['reverse_path_id_array'][] = $item['node_id'];
                                if (isset($subSiteNodeIdList[$item['node_id']]) && $data['subsite_id'] == 0) {
                                    $data['subsite_id'] = (int)$subSiteNodeIdList[$item['node_id']];
                                }
                            }
                        }
                        foreach ($path as $key => $item) {
                            $data['path_array'][] = $item;
                        }

                        if ($tpl->hasVariable('current_node_id')) {
                            $currentNodeId = (int)$tpl->variable('current_node_id');
                        } else if (isset($moduleResult['node_id'])) {
                            $currentNodeId = (int)$moduleResult['node_id'];
                        }

                        $data['current_node_id'] = (int)$currentNodeId;
                        if ($data['root_node'] == $currentNodeId) {
                            $data['is_homepage'] = true;
                        }

                        if ($data['global_root_node'] == $currentNodeId) {
                            $data['is_global_root'] = true;
                        }

                        if (isset($moduleResult['content_info']['main_node_url_alias']) && $moduleResult['content_info']['main_node_url_alias']) {
                            $data['canonical_url'] = $moduleResult['content_info']['main_node_url_alias'];
                        }

                        if (isset($moduleResult['content_info'])) {

                            if (isset($moduleResult['content_info']['main_node_url_alias']) && $moduleResult['content_info']['main_node_url_alias']) {
                                $data['canonical_url'] = $moduleResult['content_info']['main_node_url_alias'];
                            }

                            if (isset($moduleResult['content_info']['persistent_variable'])
                                && is_array($moduleResult['content_info']['persistent_variable'])) {
                                $data = array_merge($data, $moduleResult['content_info']['persistent_variable']);
                            }
                        }

                    } else {
                        $data = array_merge($data, ezjscPackerTemplateFunctions::getPersistentVariable());
                    }

                    if ($data['is_homepage']
                        || $data['is_search_page']
                        || $data['is_edit']
                        || $data['is_browse']
                        || $data['is_login_page']
                    ) {
                        $data['show_breadcrumb'] = false;
                    }

                    if (isset($data['show_path']) && $data['show_path'] == false) {
                        $data['show_breadcrumb'] = false;
                    }

                    $uriPrefix = '/';
                    eZURI::transformURI($uriPrefix);
                    $data['uri_prefix'] = rtrim($uriPrefix, '/') . '/';

                    self::$contextData = $data;
                    eZDebug::appendBottomReport('Pagedata', array('FTCoop2018Operators', 'printDebugReport'));
                }

                return $operatorValue = self::$contextData;

                break;
        }

        return null;
    }

    public static function printDebugReport($as_html = true)
    {
        if (!eZTemplate::isTemplatesUsageStatisticsEnabled())
            return '';

        $stats = '';
        if ($as_html) {
            $stats .= '<h3>Pagedata:</h3>';
            $stats .= '<table id="ftcooppagedata" class="debug_resource_usage">';
            ksort(self::$contextData);
            foreach (self::$contextData as $key => $data) {
                $value = json_encode($data);
                $stats .= "<tr class='data'><td><strong>{$key}</strong></td><td>{$value}</td></tr>";
            }
            $stats .= '</table>';            
        }

        return $stats;
    }

    private static function getSubSiteNodeListCache()
    {
        $cacheFilePath = eZSys::cacheDirectory() . '/subsite_node_list.cache';

        return eZClusterFileHandler::instance($cacheFilePath);
    }

    private static function getSubSiteNodeList()
    {
        return self::getSubSiteNodeListCache()->processCache(
            function ($file) {
                $content = include( $file );

                return $content;
            },
            function () {
                $list = array();
                $ini = eZINI::instance('ocoperatorscollection.ini');
                $identifiers = $ini->hasVariable('Subsite', 'Classes') ? $ini->variable('Subsite', 'Classes') : array();
                if (!empty($identifiers)) {
                    /** @var eZContentObjectTreeNode[] $nodes */
                    $nodes = eZContentObjectTreeNode::subTreeByNodeID(array(
                        'ClassFilterType' => 'include',
                        'ClassFilterArray' => $identifiers,
                        'LoadDataMap' => false,
                        'Limitation' => array()
                    ), 1);
                    foreach ($nodes as $node) {
                        $list[$node->attribute('node_id')] = $node->attribute('contentobject_id');
                    }
                }

                return array(
                    'content' => $list,
                    'scope' => 'cache',
                    'datatype' => 'php',
                    'store' => true
                );
            }
        );
    }

    public static function clearCache()
    {
        self::getSubSiteNodeListCache()->purge();
    }

    private function loadOpenGraphData($contentNode)
    {
        $returnArray = [];
        if ($contentNode instanceof eZContentObjectTreeNode) {
            $dataMap = $contentNode->dataMap();
            $siteName = trim(eZINI::instance()->variable('SiteSettings', 'SiteName'));
            $returnArray['og:site_name'] = $siteName;

            $urlAlias = $contentNode->urlAlias();
            eZURI::transformURI($urlAlias, false, 'full');
            $returnArray['og:url'] = $urlAlias;

            $returnArray['og:type'] = 'article';
            $returnArray['article:published_time'] = date('c', $contentNode->object()->attribute('published'));
            $returnArray['article:modified_time'] = date('c', $contentNode->object()->attribute('modified'));
            if ($contentNode->object()->attribute('owner_id') != eZINI::instance()->variable("UserSettings", "UserCreatorID")) {
                if ($owner = $contentNode->object()->attribute('owner')) {
                    $returnArray['article:author'] = $owner->attribute('name');
                }
            }else{
                $returnArray['article:author'] = $siteName;
            }

            $tags = [];
            foreach ($dataMap as $identifier => $attribute) {
                if ($attribute->attribute('data_type_string') == eZTagsType::DATA_TYPE_STRING && $attribute->hasContent()) {
                    /** @var eZTags $attributeContent */
                    $attributeContent = $attribute->content();
                    $tags = array_merge($tags, $attributeContent->attribute('keywords'));
                }
                if ($attribute->attribute('data_type_string') == eZGmapLocationType::DATA_TYPE_STRING && $attribute->hasContent()) {
                    /** @var eZGmapLocation $attributeContent */
                    $attributeContent = $attribute->content();
                    $returnArray['og:street-address'] = $attributeContent->attribute('address');
                    $returnArray['og:latitude'] = $attributeContent->attribute('latitude');
                    $returnArray['og:longitude'] = $attributeContent->attribute('longitude');
                }
                if (!isset($returnArray['og:description'])
                    && in_array($attribute->attribute('data_type_string'), [eZTextType::DATA_TYPE_STRING, eZXMLTextType::DATA_TYPE_STRING])
                    && $attribute->hasContent()) {
                    $returnArray['og:description'] = str_replace("\n", " ", strip_tags(trim($attribute->attribute('data_text'))));
                }
            }
            if (!isset($returnArray['og:description'])){
                $returnArray['og:description'] = $contentNode->attribute('name');
            }
            if (!empty($tags)) {
                $returnArray['article:tag'] = array_unique($tags);
            }

            $image = $this->loadImage(['image', 'images'], $dataMap);
            if ($image) {
                $alias = $image->attribute('reference');
                $returnArray['og:image'] = $alias['url'];
            }
            if (!isset($returnArray['og:image'])) {
                $returnArray['og:image'] = '/extension/ftcoop-2018/design/ftcoop_famigliacooperativa/images/logo-blu.png';
            }
            $returnArray['og:title'] = $contentNode->attribute('name');

            $pagedata = new \OpenPAPageData();
            $contacts = $pagedata->getContactsData();
            if (isset($contacts['email'])) {
                $returnArray['og:email'] = $contacts['email'];
            }
            if (isset($contacts['telefono'])) {
                $returnArray['og:phone_number'] = $contacts['telefono'];
            }
            if (isset($contacts['fax'])) {
                $returnArray['og:fax_number'] = $contacts['fax'];
            }

            if (isset($returnArray['og:image'])) {
                $file = eZClusterFileHandler::instance($returnArray['og:image']);
                if ($file->exists()) {
                    $file->fetch();
                    $returnArray['og:image:type'] = $file->dataType();
                    $info = getimagesize($returnArray['og:image']);
                    if ($info) {
                        $returnArray['og:image:width'] = $info[0];
                        $returnArray['og:image:height'] = $info[1];
                    }
                    $file->deleteLocal();
                }
                eZURI::transformURI($returnArray['og:image'], true, 'full');

            }

            $returnArray['og:locale'] = str_replace('-', '_', eZLocale::instance()->httpLocaleCode());
        }

        return $returnArray;
    }

    /**
     * @param string[] $mainImages
     * @param eZContentObjectAttribute[] $dataMap
     *
     * @return eZImageAliasHandler|false
     */
    private function loadImage($mainImages, $dataMap)
    {
        foreach ($mainImages as $mainImage) {
            if (isset($dataMap[$mainImage]) && $dataMap[$mainImage]->hasContent()) {
                if ($dataMap[$mainImage]->attribute('data_type_string') == eZImageType::DATA_TYPE_STRING) {

                    return $dataMap[$mainImage]->content();

                } elseif ($dataMap[$mainImage]->attribute('data_type_string') == eZObjectRelationListType::DATA_TYPE_STRING) {
                    $imagesIdList = explode('-', $dataMap[$mainImage]->toString());
                    foreach ($imagesIdList as $id) {
                        $object = eZContentObject::fetch((int)$id);
                        $dataMap = $object->dataMap();
                        $image = $this->loadImage(['image'], $dataMap);
                        if ($image) {
                            return $image;
                        }
                    }
                }
            }
        }

        return false;
    }
}
