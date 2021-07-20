<?php

require_once 'lib/Dase/DBO.php';

/**
 * @property int speech_id
 */
class Dase_DBO_Section extends Dase_DBO
{
    public function __construct($db,$assoc = false)
    {
        parent::__construct($db,'section', array('speech_act_subtype','speech_act_type','move','speech_id'));
        if ($assoc) {
            foreach ( $assoc as $key => $value) {
                $this->fields[$key] = $value;
            }
        }
    }
    public function getSpeech_act_subtype() { return $this->fields["speech_act_subtype"]; }
    public function getSpeech_act_type() { return $this->fields["speech_act_type"]; }
    public function getMove() { return $this->fields["move"]; }
    public function getSpeech_id() { return $this->fields["speech_id"]; }
}