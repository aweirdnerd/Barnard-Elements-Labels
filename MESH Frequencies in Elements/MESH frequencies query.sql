SELECT -- TOP (1000) pl.[Publication ID]
     -- ,[Property]
     -- ,[Index]
      prl.[Label]
      ,LEFT(lv.[Vocabulary ID],1) as category
	  ,lv.[Vocabulary ID]
	  --,lv.[Parent Vocabulary ID]
	  ,pv.Label as Parent
	  ,ppv.Label as GrandParent
      --,[Percentage]
   --   ,[Scheme ID]
     -- ,prl.[Scheme ID]
  , count(distinct pr.[Publication ID]) as n
  FROM [elements-lshtm-prod-reporting].[dbo].[Publication Record Label] prl 
  inner join [Publication Record] pr on prl.[Publication Record ID] = pr.ID
  inner join [Publication User Relationship] pur on pur.[Publication ID]= pr.[Publication ID]
  inner join [User] u on u.ID =  pur.[User ID]
  inner join [Label Vocabulary] lv on lv.Label=prl.Label and prl.[Scheme ID]=lv.[Scheme ID]
  left join [Label Vocabulary] pv on lv.[Parent Vocabulary ID] = pv.[Vocabulary ID]
  left join [Label Vocabulary] ppv on ppv.[Vocabulary ID]=pv.[Parent Vocabulary ID]
  where -- u.ID = 1877 and 
  prl.[Scheme ID] = 2
  
  --and lv.[Vocabulary ID] like 'X%'

  group by prl.Label ,
  lv.[Vocabulary ID],
  --lv.[Parent Vocabulary ID],
  pv.Label,ppv.Label  
-- , prl.[Scheme ID]
  order by n desc, prl.Label
  --order by lv.[Vocabulary ID]
