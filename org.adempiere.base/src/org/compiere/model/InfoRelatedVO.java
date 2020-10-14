package org.compiere.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Properties;

import org.adempiere.model.IInfoColumn;
import org.adempiere.model.MInfoRelated;
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
	
	/** Properties */
	private Properties ctx;
	
	private int AD_InfoRelated_ID;
	
	private int AD_InfoWindow_ID;
	
	private MInfoRelated infoRelated;

	private int SeqNo;

	private boolean isDisplayed;

	private String Name;
	
	/**
	 * Default Constructor
	 * @param ctx
	 * @param infoColumn
	 */
	public InfoRelatedVO(Properties ctx, MInfoRelated infoRelated) {
		
		this.ctx = ctx;
		
		this.infoRelated = infoRelated;
		
		this.isDisplayed = infoRelated.isActive();
		
		this.AD_InfoRelated_ID = infoRelated.getAD_InfoRelated_ID();
		
		this.AD_InfoWindow_ID = infoRelated.getAD_InfoWindow_ID();
		
		this.SeqNo = infoRelated.getSeqNo();
		
		MInfoWindow riw = (MInfoWindow) infoRelated.getRelatedInfo();
		if (riw != null)
			this.Name = Util.cleanAmp(riw.get_Translation("Name"));
		else
			this.Name = infoRelated.getName();
		
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
		}		
	}

	/**
	 * Default Constructor
	 * @param ctx
	 * @param infoColumn
	 */
	public static InfoRelatedVO[] getInfoRelatedVOList(Properties ctx, MInfoRelated[] infoRelatedList) {
		ArrayList<InfoRelatedVO> infoRelatedVOList = new ArrayList<InfoRelatedVO>();
		// Create Info Related VO
		for(MInfoRelated infoRelated : infoRelatedList) {
			InfoRelatedVO infoRelatedVO = new InfoRelatedVO(ctx, infoRelated);
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

	public boolean isDisplayed() {
		return this.isDisplayed;
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
}
