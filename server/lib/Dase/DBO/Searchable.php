<?php

require_once 'lib/Dase/DBO.php';

/**
 * @property int speech_id
 * @property mixed attribute
 */
class Dase_DBO_Searchable extends Dase_DBO
{
    public function __construct($db,$assoc = false)
    {
        parent::__construct($db,'searchable', array('attribute','value','speech_id'));
        if ($assoc) {
            foreach ( $assoc as $key => $value) {
                $this->fields[$key] = $value;
            }
        }
    }
    public function getAttribute() { return $this->fields["attribute"]; }
    public function getValue() { return $this->fields["value"]; }
    public function getSpeech_id() { return $this->fields["speech_id"]; }
}