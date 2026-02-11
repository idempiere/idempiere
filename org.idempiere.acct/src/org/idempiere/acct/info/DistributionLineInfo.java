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

import org.adempiere.base.acct.info.IAccountInfo;
import org.adempiere.base.acct.info.IDistributionLineInfo;
import org.compiere.model.I_GL_DistributionLine;
import org.compiere.model.PO;
import org.idempiere.acct.model.MAccount;
import org.idempiere.acct.model.MDistributionLine;

/**
 * Wrapper for {@link MDistributionLine} to provide {@link IDistributionLineInfo} access.
 * 
 * @author etantg
 */
public class DistributionLineInfo implements IDistributionLineInfo {
	
	private final MDistributionLine line;
	
	public DistributionLineInfo(MDistributionLine line) {
        if (line == null)
            throw new IllegalArgumentException("MDistributionLine cannot be null");
        this.line = line;
    }
	
	public MDistributionLine getModel() {
		return line;
	}
	
	@Override
	public I_GL_DistributionLine getRecord() {
		return line;
	}

	@Override
	public PO getPO() {
		return line;
	}

	@Override
	public IAccountInfo getAccountInfo() {
		MAccount account = line.getAccount();
		return AccountInfo.wrap(account);
	}
	
	@Override
	public BigDecimal getAmt() {
		return line.getAmt();
	}

	@Override
	public BigDecimal getQty() {
		return line.getQty();
	}

	public static IDistributionLineInfo wrap(MDistributionLine line) {
        if (line == null)
            return null;
        if (line instanceof IDistributionLineInfo)
            return (IDistributionLineInfo) line;
        return new DistributionLineInfo(line);
    }
	
	public static IDistributionLineInfo[] wrapStream(MDistributionLine[] lines) {
		return lines == null ? new IDistributionLineInfo[0] :
		       Arrays.stream(lines)
		             .map(DistributionLineInfo::wrap)  // wrap each element
		             .toArray(IDistributionLineInfo[]::new);
    }
	
}
