package org.compiere.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.model.IInfoColumn;
import org.adempiere.model.MInfoRelated;
import org.compiere.util.CLogger;
import org.compiere.util.Env;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;
import org.compiere.util.Util;

/**
 * Info Related Value Object
 * @author Igor Pojzl, Cloudempiere
 * @version $Id$
 */
public class InfoRelatedVO implements Serializable, Cloneable, IInfoColumn {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3683704870522235708L;
	
	/**	Logger			*/
	private static CLogger	log = CLogger.getCLogger(InfoRelatedVO.class);
	
	/** Properties */
	private Properties ctx;
	
	private int AD_InfoRelated_ID;
	
	private int AD_InfoWindow_ID;
	
	private MInfoRelated infoRelated;

	private int SeqNo;
	
	private String DisplayLogic;

	private String Name;

	private int WindowNo;
	
	/**
	 * Default Constructor
	 * @param ctx
	 * @param infoRelated
	 * @param windowNo
	 */
	public InfoRelatedVO(Properties ctx, MInfoRelated infoRelated, int windowNo) {
		
		this.ctx = ctx;
		
		this.infoRelated = infoRelated;
				
		this.AD_InfoRelated_ID = infoRelated.getAD_InfoRelated_ID();
		
		this.AD_InfoWindow_ID = infoRelated.getAD_InfoWindow_ID();
		
		this.SeqNo = infoRelated.getSeqNo();
		
		this.DisplayLogic = infoRelated.getDisplayLogic();
		
		MInfoWindow riw = (MInfoWindow) infoRelated.getRelatedInfo();
		if (riw != null)
			this.Name = Util.cleanAmp(riw.get_Translation("Name"));
		else
			this.Name = infoRelated.getName();
		
		this.WindowNo = windowNo;
		
		this.afterCreate();		
	}
	
	public void afterCreate() {
		InfoRelatedVO vo = this;
		
		// InfoColumn Customization
		MUserDefInfoRelated userDef = null;
		userDef = MUserDefInfoRelated.get(vo.ctx,vo.AD_InfoRelated_ID, vo.AD_InfoWindow_ID);
		if (userDef != null)
		{
			if (userDef.getName() != null)
				vo.Name = userDef.getName();
			if (userDef.get_Translation("Name") != null)
				vo.Name = userDef.get_Translation("Name");
			if (userDef.getSeqNo() > 0)
			    vo.SeqNo= userDef.getSeqNo();
			if (userDef.getDisplayLogic() != null)
				vo.DisplayLogic = userDef.getDisplayLogic();
		}		
	}

	/**
	 * Default Constructor
	 * @param ctx
	 * @param infoRelatedList
	 * @param windowNo
	 * @return
	 */
	public static InfoRelatedVO[] getInfoRelatedVOList(Properties ctx, MInfoRelated[] infoRelatedList, int windowNo) {
		ArrayList<InfoRelatedVO> infoRelatedVOList = new ArrayList<InfoRelatedVO>();
		// Create Info Related VO
		for(MInfoRelated infoRelated : infoRelatedList) {
			InfoRelatedVO infoRelatedVO = new InfoRelatedVO(ctx, infoRelated, windowNo);
			infoRelatedVOList.add(infoRelatedVO);
		}
		
		// Sort List By SeqNo
		infoRelatedVOList.sort(new Comparator<InfoRelatedVO>() {

			@Override
			public int compare(InfoRelatedVO o1, InfoRelatedVO o2) {
				Integer o1SeqNo = Integer.valueOf(o1.getSeqNo());
				Integer o2SeqNo = Integer.valueOf(o2.getSeqNo());
				return o1SeqNo.compareTo(o2SeqNo);
			}
		});
		
		return infoRelatedVOList.toArray(new InfoRelatedVO[infoRelatedVOList.size()]);
	}

	public int getRelatedInfo_ID() {
		return infoRelated.getRelatedInfo_ID();
	}

	public String getLinkColumnName() {
		return infoRelated.getLinkColumnName();
	}

	public int getParentRelatedColumn_ID() {
		return infoRelated.getParentRelatedColumn_ID();
	}

	public I_AD_InfoWindow getRelatedInfo() {
		return infoRelated.getRelatedInfo();
	}

	public MInfoColumn getLinkInfoColumn() {
		return infoRelated.getLinkInfoColumn();
	}

	public String getName() {
		return Name;
	}

	public I_AD_InfoColumn getParentRelatedColumn() {
		return infoRelated.getParentRelatedColumn();
	}
	
	public int getSeqNo() {
		return this.SeqNo;
	}

	/**
	 * Just forward call to {@link #getParentRelatedColumn_ID()}
	 */
	@Override
	public int getInfoColumnID() {
		return getParentRelatedColumn_ID();
	}
	
	/**
	 * Just forward call to {@link #getParentRelatedColumn()}
	 */
	@Override
	public MInfoColumn getAD_InfoColumn (){
		return (MInfoColumn) getParentRelatedColumn();
	}

	public String getDisplayLogic() {
		return DisplayLogic;
	}
	
	/**************************************************************************
	 *	Is the Related Window Visible ?
	 *  @return true, if visible
	 */
	public boolean isDisplayed (final Properties ctx)
	{
		//  no restrictions
		if (Util.isEmpty(getDisplayLogic()))
			return true;

		if (getDisplayLogic().startsWith("@SQL=")) {
			return Evaluator.parseSQLLogic(DisplayLogic, ctx, WindowNo, 0, infoRelated.toString());
		}
		Evaluatee evaluatee = new Evaluatee() {
			public String get_ValueAsString(String variableName) {
				return InfoRelatedVO.this.get_ValueAsString(ctx, variableName);
			}
		};
		boolean retValue = Evaluator.evaluateLogic(evaluatee, getDisplayLogic());
		if (log.isLoggable(Level.FINEST)) log.finest(infoRelated.toString()
			+ " (" + getDisplayLogic() + ") => " + retValue);
		return retValue;

	}	//	isDisplayed
	
	
	/**
	 * 	Get Variable Value (Evaluatee)
	 *	@param variableName name
	 *	@return value
	 */
	public String get_ValueAsString (Properties ctx, String variableName)
	{
		int f = variableName.indexOf('.');
		if (f > 0) {
			variableName = variableName.substring(0, f);
		}
		
		String value = null;		
	    value = Env.getContext (ctx, WindowNo, variableName, true);
	   
		return value;
	}	//	get_ValueAsString
}
