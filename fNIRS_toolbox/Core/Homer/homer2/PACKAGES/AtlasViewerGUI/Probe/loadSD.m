function probe = loadSD(probe,SD)


if(isfield(SD,'Lambda'))
    probe.lambda=SD.Lambda;
else
    probe.lambda=[];
end

% Determine units of src/det coordinates
if(isfield(SD,'SpatialUnit'))
    unitsStr = SD.SpatialUnit;
else
    unitsStr = 'mm';
end
sdUnitsFactor = 1;
if ischar(unitsStr) && strcmp(unitsStr,'cm')
    sdUnitsFactor = 10;   % convert to mm if SD units are cm
end

if(isfield(SD,'SrcPos'))
    probe.srcpos=sdUnitsFactor*SD.SrcPos;
else
    probe.srcpos=[];
end
if(isfield(SD,'DetPos'))
    probe.detpos=sdUnitsFactor*SD.DetPos;
else
    probe.detpos=[];
end
if(isfield(SD,'DummyPos'))
    probe.dummypos=SD.DummyPos;
else
    probe.dummypos=[];
end
if(isfield(SD,'nSrcs'))
    probe.nsrc=SD.nSrcs;
else
    probe.nsrc=size(probe.srcpos,1);
end
if(isfield(SD,'nDets'))
    probe.ndet=SD.nDets;
else size(probe.detpos,1)
    probe.ndet=size(probe.detpos,1);
end
if(isfield(SD,'nDummys'))
    probe.ndummy=SD.nDummys;
else
    probe.ndummy=0;
end
if(isfield(SD,'MeasList')) && ~isempty(SD.MeasList) && size(SD.MeasList,2)>=4
    k = find(SD.MeasList(:,4)==1);
    probe.ml = SD.MeasList(k,:);
elseif(isfield(SD,'MeasList')) && ~isempty(SD.MeasList) && size(SD.MeasList,2)<4
    probe.ml = SD.MeasList;
else
    probe.ml=[];
end
if(isfield(SD,'SpringList'))
    probe.sl=SD.SpringList;
else
    probe.sl=[];
end
if(isfield(SD,'AnchorList'))
    probe.al=SD.AnchorList;
else
    probe.al=[];
end

probe.optpos = [probe.srcpos; probe.detpos; probe.dummypos];
probe.noptorig = size([probe.srcpos; probe.detpos],1);
