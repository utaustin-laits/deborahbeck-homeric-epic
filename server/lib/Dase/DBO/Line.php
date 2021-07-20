<?php

require_once 'lib/Dase/DBO.php';

/**
 * @property mixed book
 * @property mixed work
 */
class Dase_DBO_Line extends Dase_DBO
{
    public function __construct($db,$assoc = false)
    {
        parent::__construct($db,'line', array('speech_text','line_num','book','work'));
        if ($assoc) {
            foreach ( $assoc as $key => $value) {
                $this->fields[$key] = $value;
            }
        }
    }
    public function getSpeech_text() { return $this->fields["speech_text"]; }
    public function getLine_num() { return $this->fields["line_num"]; }
    public function getBook() { return $this->fields["book"]; }
    public function getWork() { return $this->fields["work"]; }
}