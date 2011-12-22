package model
{
  public class Kazuate
  {
    //------------------------------
    // Properties
    //------------------------------
    [Bindable]
    public var answerString:String;

    [Bindable]
    public var resultString:String;

    [Bindable]
    public var isHomerun:Boolean = false;

    [Bindable]
    public var isOut:Boolean = false;

    public function get inputSize():int
    {
      return blocks.length;
    }
    public function set inputSize(value:int):void
    {
      if (value > 10)
      {
        throw new Error("unko size");
      }
      blocks = new Vector.<Block>(value);
      createAnswer();
    }

    public var blocks:Vector.<Block> = new Vector.<Block>(3);


    //------------------------------
    // Constructor
    //------------------------------
    public function Kazuate()
    {
      super();

      start();
    }

    //-------------------------------
    // public methods
    //-------------------------------

    public function start():void
    {
      createAnswer();
    }

    public function checkAnswer():void
    {
      if (!validateInput())
      {
        return;
      }

      var board:ScoreBoard = new ScoreBoard(blocks);
      resultString = board.score.toString();
    }

    public function setInput(index:int, value:String):void
    {
      if (index > inputSize)
      {
        throw new Error("unko index");
      }
      var check:Boolean = value && value.match(/[0-9]+/).length == 1;
      var i:int = check ? int(value) : -1;
      blocks[index].input = i;
    }


    //-------------------------
    // private methods
    //-------------------------

    private function createAnswer():void
    {
      var ansStr:String = "";
      var numList:Array = [0,1,2,3,4,5,6,7,8,9];
      for (var i:int=0; i<inputSize; i++)
      {
        blocks[i] = new Block();
        var random:int = int(Math.random() * (numList.length-i)) + i;
        var tmp:int = numList[i];
        numList[i] = numList[random];
        numList[random] = tmp;
        blocks[i].answer = numList[i];
        ansStr += numList[i].toString();
      }
      answerString = ansStr;
    }

    private function validateInput():Boolean
    {
      // TODO:インプットチェック
      return true;
    }
  }
}

class Block
{
  public var answer:int = -1;
  public var input:int = -1;

  //-----------------------------------
  // constructor
  //-----------------------------------
  public function Block()
  {
  }

  public function isSame():Boolean
  {
    return answer == input;
  }
}

class ScoreBoard
{
  public var score:Score;

  //-----------------------------------
  // constructor
  //-----------------------------------
  public function ScoreBoard(blocks:Vector.<Block>)
  {
    score = new Score();

    checkStrike(blocks);
    checkBall(blocks);
  }

  private function checkStrike(blocks:Vector.<Block>):void
  {
    var length:int = blocks.length;
    for (var i:int=0; i<length; i++)
    {
      if (blocks[i].isSame())
      {
        score.strikeCount++;
      }
    }
    score.isHomerun = (score.strikeCount == length);
  }

  private function checkBall(blocks:Vector.<Block>):void
  {
    var length:int = blocks.length;
    for (var i:int=0; i<length; i++)
    {
      var tmp:int = blocks[i].input;
      for (var j:int=0; j<length; j++)
      {
        if (blocks[j].answer == tmp)
        {
          score.ballCount++;
          break;
        }
      }
    }
    score.ballCount -= score.strikeCount;
    score.isOut = (score.strikeCount == 0 && score.ballCount == 0);
  }
}

class Score
{
  public var strikeCount:int = 0;
  public var ballCount:int = 0;
  public var isHomerun:Boolean = false;
  public var isOut:Boolean = false;

  //-----------------------------------
  // constructor
  //-----------------------------------
  public function Score()
  {
  }

  public function toString():String
  {
    var str:String;
    if (isHomerun)
    {
      str = "HOMERUN";
    }
    else if (isOut)
    {
      str = "OUT";
    }
    else
    {
      str = strikeCount.toString() + "S";
      str += ballCount.toString() + "B";
    }
    return str;
  }
}
