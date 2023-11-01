codeunit 50000 "Progress Bar Management"
{
    // PBM1.11 06.10.11 DFP - Fixed bug when setting intervals with no records
    // PBM1.10 04.27.11 DFP - Improved error handling in SetIntervals function
    // PBM1.xx 01.24.11 DFP - Added Update and COMMIT interval functionality
    //                      NOTE: This could be done better as parameters on OpenProgressBar, but
    //                            did not want to break compatibility with prior versions.  To use,
    //                            call SetIntervals AFTER OpenProgressBar.
    // PBM1.xx 01.14.04 DFP - Added Est. Remaining Time to display
    // PBM1.xx 12.16.03 DFP - Update to operate silently if no recs instead of error
    trigger OnRun()
    begin
    end;

    var
        Window: Dialog;
        DPos: BigInteger;
        DTotalCnt: BigInteger;
        MPos: BigInteger;
        MTotalCnt: BigInteger;
        UpdateInterval: Integer;
        CommitInterval: Integer;
        AutoCommit: Boolean;
        ShowTime: Boolean;
        NoRecs: Boolean;
        MasterMode: Boolean;
        PBOpened: Boolean;
        StartDateTime: DateTime;
        EndDateTime: DateTime;
        RemTime: Text[100];
        Text001: Label '%1 cannot be less than 1.';
        Text002: Label 'Function SetIntervals must be called after opening Progress Bar.';

    procedure OpenProgressBar(DTextIn: Text[250]; DTotalCntIn: Integer; AutoCommitIn: Boolean; ShowTimeIn: Boolean)
    var
        TimeText: Text[250];
    begin
        Clear(StartDateTime);
        Clear(EndDateTime);
        Clear(RemTime);
        NoRecs := (DTotalCntIn <= 0);
        if DTotalCntIn < 0 then Error('Progress Bar Total Iterations cannot be 0 or negative.');
        if NoRecs then exit;
        DPos := 0;
        DTotalCnt := DTotalCntIn;
        UpdateInterval := 1;
        CommitInterval := 1;
        AutoCommit := AutoCommitIn;
        MasterMode := false;
        // Reduce the textin to max of 30 characters
        DTextIn := CopyStr(DTextIn, 1, 30);
        // Pad the textin out to 30 characters
        DTextIn := PadStr(DTextIn, 30);
        ShowTime := ShowTimeIn;
        if ShowTimeIn then begin
            TimeText := '        Start Time               #4##############\\' + '        Est. End Time            #5##############\\' + '        Est. Time Remaining      #6##############\\'
        end
        else
            TimeText := '';
        StartDateTime := CurrentDateTime;
        // Open the Window
        Window.Open(DTextIn + ' #1##### of #2#####\\' + TimeText + '@3@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
        Window.Update(1, Format(DPos));
        Window.Update(2, Format(DTotalCnt));
        if ShowTime then begin
            Window.Update(4, Format(StartDateTime));
        end;
        PBOpened := true;
    end;

    procedure OpenMasterProgressBar(mTextIn: Text[250]; mTotalCntIn: Integer; AutoCommitIn: Boolean; ShowTimeIn: Boolean)
    var
        TimeText: Text[250];
    begin
        NoRecs := (mTotalCntIn <= 0);
        if mTotalCntIn < 0 then Error('Progress Bar Total Iterations cannot be 0 or negative.');
        if NoRecs then exit;
        MPos := 0;
        MTotalCnt := mTotalCntIn;
        UpdateInterval := 1;
        UpdateInterval := 1;
        AutoCommit := AutoCommitIn;
        MasterMode := true;
        // Reduce the textin to max of 30 characters
        mTextIn := CopyStr(mTextIn, 1, 30);
        // Pad the textin out to 30 characters
        mTextIn := PadStr(mTextIn, 30);
        ShowTime := ShowTimeIn;
        if ShowTimeIn then begin
            TimeText := '        Start Time               #4##############\\' + '        Est. End Time            #5##############\\' + '        Est. Time Remaining      #6##############\\'
        end
        else
            TimeText := '';
        StartDateTime := CurrentDateTime;
        // Open the Window
        Window.Open(mTextIn + ' #7##### of #8#####\\' + '@9@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@\\\\' + '#10########################### #1##### of #2#####\\' + TimeText + '@3@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@');
        Window.Update(7, Format(MPos));
        Window.Update(8, Format(MTotalCnt));
        if ShowTime then begin
            Window.Update(4, Format(StartDateTime));
        end;
        PBOpened := true;
    end;

    procedure UpdateMasterProgressBar(DTextIn: Text[250]; DTotalCntIn: Integer)
    var
        TimeText: Text[250];
    begin
        MPos += 1;
        NoRecs := (DTotalCntIn <= 0);
        if DTotalCntIn < 0 then Error('Progress Bar Total Iterations cannot be 0 or negative.');
        if NoRecs then exit;
        DPos := 0;
        DTotalCnt := DTotalCntIn;
        // Reduce the textin to max of 30 characters
        DTextIn := CopyStr(DTextIn, 1, 30);
        // Pad the textin out to 30 characters
        DTextIn := PadStr(DTextIn, 30);
        Window.Update(10, DTextIn);
        Window.Update(7, Format(MPos));
        Window.Update(2, Format(DTotalCntIn));
        Window.Update(9, Round(MPos / MTotalCnt * 10000, 1));
    end;

    procedure UpdateProgressBar()
    begin
        if NoRecs then exit;
        if ((DPos mod UpdateInterval) = 0) then begin
            Window.Update(1, Format(DPos));
            Window.Update(3, Round(DPos / DTotalCnt * 10000, 1));
            if ShowTime then begin
                UpdateEndTime;
                Window.Update(5, Format(EndDateTime));
                Window.Update(6, RemTime);
            end;
        end;
        if AutoCommit then begin
            if ((DPos mod CommitInterval) = 0) then begin
                Commit;
            end;
        end;
        DPos += 1;
    end;

    procedure CloseProgressBar()
    begin
        if NoRecs then exit;
        Window.Close;
    end;

    procedure OpenWindow(TextMessage: Text[250])
    begin
        // Open the Window
        Window.Open(TextMessage);
    end;

    procedure CloseWindow()
    begin
        Window.Close;
    end;

    local procedure UpdateEndTime()
    var
        TimeUsed: BigInteger;
        PercentComplete: Decimal;
        TotalTime: BigInteger;
        RemTimeInt: BigInteger;
        RemDays: BigInteger;
        RemHrs: BigInteger;
        RemMin: BigInteger;
        RemSec: BigInteger;
    begin
        TimeUsed := CurrentDateTime - StartDateTime;
        PercentComplete := DPos / DTotalCnt;
        if PercentComplete <> 0 then begin
            TotalTime := Round(TimeUsed / PercentComplete, 1);
            EndDateTime := StartDateTime + TotalTime;
            RemTimeInt := TotalTime - TimeUsed;
            RemTime := '';
            RemHrs := 0;
            RemMin := 0;
            RemSec := 0;
            RemDays := RemTimeInt div (24 * 3600000);
            RemTimeInt := RemTimeInt mod (24 * 3600000);
            RemHrs := RemTimeInt div 3600000;
            RemTimeInt := RemTimeInt mod 3600000;
            RemMin := RemTimeInt div 60000;
            RemTimeInt := RemTimeInt mod 60000;
            RemSec := RemTimeInt div 1000;
            Clear(RemTime);
            if RemDays > 0 then RemTime := RemTime + Format(RemDays) + ' Days ';
            if RemHrs > 0 then RemTime := RemTime + Format(RemHrs) + ' Hrs. ';
            if RemMin > 0 then RemTime := RemTime + Format(RemMin) + ' Min. ';
            if RemSec > 0 then RemTime := RemTime + Format(RemSec) + ' Sec. ';
        end;
    end;

    procedure SetIntervals(UpdateIntervalIn: Integer; CommitIntervalIn: Integer)
    begin
        if NoRecs then // Function unneccesary; no records to process
            exit;
        if not PBOpened then // Function SetIntervals must be called after opening Progress Bar.
            Error(Text002);
        if UpdateIntervalIn < 1 then // %1 cannot be less than 1.
            Error(Text001, 'Progress Bar Update Interval');
        if CommitIntervalIn < 1 then // Code wants no COMMIT; will not COMMIT based on AutoCommit setting
            CommitIntervalIn := 1;
        UpdateInterval := UpdateIntervalIn;
        CommitInterval := CommitIntervalIn;
    end;
}
