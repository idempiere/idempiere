/***********************************************************************
 * This file is part of iDempiere ERP Open Source                      *
 * http://www.idempiere.org                                            *
 *                                                                     *
 * Copyright (C) Contributors                                          *
 *                                                                     *
 * This program is free software; you can redistribute it and/or       *
 * modify it under the terms of the GNU General Public License         *
 * as published by the Free Software Foundation; either version 2      *
 * of the License, or (at your option) any later version.              *
 *                                                                     *
 * This program is distributed in the hope that it will be useful,     *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of      *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the        *
 * GNU General Public License for more details.                        *
 *                                                                     *
 * You should have received a copy of the GNU General Public License   *
 * along with this program; if not, write to the Free Software         *
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,          *
 * MA 02110-1301, USA.                                                 *
 *                                                                     *
 **********************************************************************/
package org.idempiere.acct.info;

import java.math.BigDecimal;
import java.util.Arrays;

import org.adempiere.base.acct.model.IAccountModel;
import org.adempiere.base.acct.model.IDistributionModel;
import org.adempiere.base.acct.model.IDistributionLineModel;
import org.compiere.model.I_GL_Distribution;
import org.compiere.model.PO;
import org.idempiere.acct.model.MDistribution;
import org.idempiere.acct.model.MDistributionLine;

/**
 * Wrapper for {@link MDistribution} to provide {@link IDistributionModel} access.
 * 
 * @author etantg
 */
public class DistributionInfo implements IDistributionModel {
	
	private final MDistribution distribution;
	
	public DistributionInfo(MDistribution distribution) {
        if (distribution == null)
            throw new IllegalArgumentException("MDistribution cannot be null");
        this.distribution = distribution;
    }
	
	public MDistribution getModel() {
		return distribution;
	}
	
	@Override
	public I_GL_Distribution getGLDistribution() {
		return distribution;
	}

	@Override
	public PO getPO() {
		return distribution;
	}

	@Override
	public IDistributionLineModel[] getDistributionLines(boolean reload) {
		MDistributionLine[] lines = distribution.getLines(reload);
		return DistributionLineInfo.wrapStream(lines);
	}

	@Override
	public void distribute(IAccountModel acct, BigDecimal Amt, BigDecimal Qty, int C_Currency_ID) {
		if (acct instanceof AccountInfo) {
			distribution.distribute(((AccountInfo) acct).getModel(), Amt, Qty, C_Currency_ID);
		}
		throw new IllegalArgumentException("Unsupported IAccountInfo implementation");
	}

	@Override
	public String validate() {
		return distribution.validate();
	}
	
	public static IDistributionModel wrap(MDistribution distribution) {
        if (distribution == null)
            return null;
        if (distribution instanceof IDistributionModel)
            return (IDistributionModel) distribution;
        return new DistributionInfo(distribution);
    }
	
	public static IDistributionModel[] wrapStream(MDistribution[] distributions) {
		return distributions == null ? new IDistributionModel[0] :
			Arrays.stream(distributions)
				.map(DistributionInfo::wrap)  // wrap each element
				.toArray(IDistributionModel[]::new);
	}
	
}
