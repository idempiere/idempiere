package org.compiere.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Properties;
import java.util.logging.Level;

import org.adempiere.model.IInfoColumn;
import org.adempiere.model.MInfoRelated;
import org.compiere.util.CLogger;
import org.compiere.util.DefaultEvaluatee;
import org.compiere.util.Evaluatee;
import org.compiere.util.Evaluator;
import org.compiere.util.Util;

/**
 * Related Info Value Object
 * @author Igor Pojzl, Cloudempiere
 * @version $Id$
 */
public class InfoRelatedVO implements Serializable, Cloneable, IInfoColumn {

	/**
	 * generated serial id
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
	
	/**
	 * Process user define customization
	 */
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

	/**
	 * @return AD_InfoWindow_ID of related info window
	 */
	public int getRelatedInfo_ID() {
		return infoRelated.getRelatedInfo_ID();
	}

	/**
	 * @return link column name
	 */
	public String getLinkColumnName() {
		return infoRelated.getLinkColumnName();
	}

	/**
	 * @return parent related AD_InfoColumn_ID
	 */
	public int getParentRelatedColumn_ID() {
		return infoRelated.getParentRelatedColumn_ID();
	}

	/**
	 * @return related I_AD_InfoWindow
	 */
	public I_AD_InfoWindow getRelatedInfo() {
		return infoRelated.getRelatedInfo();
	}

	/**
	 * @return Link MInfoColumn
	 */
	public MInfoColumn getLinkInfoColumn() {
		return infoRelated.getLinkInfoColumn();
	}

	/**
	 * @return name
	 */
	public String getName() {
		return Name;
	}

	/**
	 * @return parent related I_AD_InfoColumn
	 */
	public I_AD_InfoColumn getParentRelatedColumn() {
		return infoRelated.getParentRelatedColumn();
	}
	
	/**
	 * @return sequence number
	 */
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

	/**
	 * @return display logic
	 */
	public String getDisplayLogic() {
		return DisplayLogic;
	}
	
	/**
	 *	Is the Related Window Visible ?
	 *  @return true, if visible
	 */
	public boolean isDisplayed (final Properties ctx)
	{
		//  no restrictions
		if (Util.isEmpty(getDisplayLogic()))
			return true;

		if (getDisplayLogic().startsWith(MColumn.VIRTUAL_UI_COLUMN_PREFIX)) {
			return Evaluator.parseSQLLogic(DisplayLogic, ctx, WindowNo, 0, infoRelated.toString());
		}
		Evaluatee evaluatee = (variableName) -> {return get_ValueAsString(ctx, variableName);};
		boolean retValue = Evaluator.evaluateLogic(evaluatee, getDisplayLogic());
		if (log.isLoggable(Level.FINEST)) log.finest(infoRelated.toString()
			+ " (" + getDisplayLogic() + ") => " + retValue);
		return retValue;

	}	//	isDisplayed
		
	/**
	 * 	Get Variable Value (Evaluatee) as string
	 *  @param ctx
	 *	@param variableName name
	 *	@return value as string
	 */
	public String get_ValueAsString (Properties ctx, String variableName)
	{
		DefaultEvaluatee evaluatee = new DefaultEvaluatee(null, WindowNo, -1, true);
		return evaluatee.get_ValueAsString(ctx, variableName);
	}	//	get_ValueAsString
}
